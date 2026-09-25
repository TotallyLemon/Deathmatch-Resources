#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

void main(){
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = texCoord;

    vec3 texColor = texture(InSampler, uv).rgb;
    texColor = vec3(dot(texColor, vec3(0.2, 0.7, 0.1)));

    // Output to screen
    fragColor = vec4(texColor,1.0);
}
