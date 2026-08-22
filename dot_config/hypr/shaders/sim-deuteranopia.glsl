// sim-deuteranopia.glsl — SIMULATES — no green cones (the common one)
#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;
void main() {
    vec4 p = texture(tex, v_texcoord);
    fragColor = vec4(dot(p.rgb, vec3(0.625, 0.375, 0.000)),
                     dot(p.rgb, vec3(0.700, 0.300, 0.000)),
                     dot(p.rgb, vec3(0.000, 0.300, 0.700)), p.a);
}
