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
    uv -= vec2(0.5);
    uv = vec2(atan(uv.y, uv.x), length(uv));
    float vignette = max(0., min(1., (0.4 - uv.y)*(cos(iTime*1.2)+1.)*0.65));

    uv = texCoord;
    vec3 texColor = texture(InSampler, uv).rgb;
    texColor *= vignette;

    // Output to screen
    fragColor = vec4(texColor,1.0);
}
