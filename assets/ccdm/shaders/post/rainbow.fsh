#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:globals.glsl>

#define iTime (GameTime * 1200.0)

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

void main(){

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = texCoord;

    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    vec3 texColor = texture(InSampler, uv).rgb;
    texColor *= col;

    // Output to screen
    fragColor = vec4(texColor,1.0);
}
