// tritanopia.glsl — no blue cones
#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;
void main() {
    vec4 p = texture(tex, v_texcoord);
    fragColor = vec4(dot(p.rgb, vec3(0.950, 0.050, 0.000)),
                     dot(p.rgb, vec3(0.000, 0.433, 0.567)),
                     dot(p.rgb, vec3(0.000, 0.475, 0.525)), p.a);
}
