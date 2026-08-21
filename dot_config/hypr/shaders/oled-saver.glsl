// oled-saver.glsl — dim, then crush near-black to true black (an off pixel draws no power)
#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;
const float DIM = 0.85;
const float FLOOR = 0.04;   // below this, snap to 0 rather than glowing dark grey
void main() {
    vec4 p = texture(tex, v_texcoord);
    vec3 c = p.rgb * DIM;
    c *= step(FLOOR, max(c.r, max(c.g, c.b)));   // step -> 0 kills the whole pixel
    fragColor = vec4(c, p.a);
}
