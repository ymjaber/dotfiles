// protanopia.glsl — no red cones
#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;
void main() {
    vec4 p = texture(tex, v_texcoord);
    fragColor = vec4(dot(p.rgb, vec3(0.567, 0.433, 0.000)),
                     dot(p.rgb, vec3(0.558, 0.442, 0.000)),
                     dot(p.rgb, vec3(0.000, 0.242, 0.758)), p.a);
}
