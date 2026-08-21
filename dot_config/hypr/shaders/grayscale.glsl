// grayscale.glsl — Rec.709 luma
#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;
void main() {
    vec4 p = texture(tex, v_texcoord);
    fragColor = vec4(vec3(dot(p.rgb, vec3(0.2126, 0.7152, 0.0722))), p.a);
}
