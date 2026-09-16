#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

void main(){

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = texCoord;
    uv.x -= 0.5;
    uv.y -= 0.8;
    uv =vec2(atan(uv.y, uv.x), length(uv));
    float vignette = smoothstep(0., 0.4, max(0., min(1., (0.85 - uv.y)*2.2)));

    uv = texCoord;
    
    vec3 texColor = texture(InSampler, uv).rgb;
    
    // Apply grayscale filter
    float grayScale = dot(texColor, vec3(0.2, 0.7, 0.1));
    texColor = mix(vec3(grayScale), texColor, vignette);

    // Output to screen
    fragColor = vec4(texColor, 0);
}
