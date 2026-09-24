#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:globals.glsl>

#define iTime (GameTime * 1200.0)

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

#define PI 3.14159

float hash13(vec3 p3) {
	p3  = fract(p3 * .1031);
    p3 += dot(p3, p3.zyx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec2 gradient(vec3 p) {
    float angle = hash13(p) * 2.*PI;
    
    return vec2(cos(angle), sin(angle));
}

float noise(vec3 p) {
    vec3 fl = floor(p);
    vec2 fr = fract(p.xy);
    float r1 = dot(fr, gradient(fl));
    float r2 = dot(fr-vec2(0,1), gradient(fl + vec3(0, 1, 0)));
    float r3 = dot(fr-vec2(1,0), gradient(fl + vec3(1, 0, 0)));
    float r4 = dot(fr-vec2(1,1), gradient(fl + vec3(1, 1, 0)));
    
    fr = smoothstep(0.0, 1.0, fr);
    return mix(mix(r1, r2, fr.y), mix(r3, r4, fr.y), fr.x);
}

void main(){

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = texCoord;
    vec3 col = vec3(0.58, 0.25, 0.62);

    // Screen distortion
    float r1 = 0.002*noise(vec3(uv * 20., iTime));
    float r2 = 0.002*noise(vec3(uv * 20., iTime+1.));
    uv += mix(r1, r2, fract(iTime));
    vec3 texColor = texture(InSampler, uv).rgb;

    // Colorize
    vec3 colorize = vec3((texColor.r + texColor.g + texColor.b) / 3.) * col;
    texColor = mix(colorize, texColor, 0.64);
    
    // Output to screen
    fragColor = vec4(texColor,1.0);
}