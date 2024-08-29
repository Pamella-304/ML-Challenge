//
//  Shaders.metal
//  ML
//
//  Created by Carol Quiterio on 27/08/24.
//

#include <metal_stdlib>
using namespace metal;

[[stitchable]] float2 rotate(float2 pos, float time) {
    float rotationSpeed = 0.2;
    
    float angle = sin(time) * rotationSpeed;
    
    float s = sin(angle);
    float c = cos(angle);
    
    float2 rotatedPos;
    rotatedPos.x = c * pos.x - s * pos.y;
    rotatedPos.y = s * pos.x + c * pos.y;

    return rotatedPos;
}

[[stitchable]] float2 wave(float2 pos, float time) {
    pos.y += sin(time*5 + pos.y/100) * 10;
    
    return pos;
}

[[stitchable]] float2 jump(float2 pos, float time) {
    pos.y += sin(time) * 20;

    pos.x += sin(time * 2) * 1;

    return pos;
}

// Não usado
[[stitchable]] float2 walk(float2 pos, float time, float width) {
    pos.x -= time * 20.0;

    pos.x = pos.x + width * (pos.x < 0 ? 1 : 0);
    pos.x = pos.x - floor(pos.x / width) * width;

    return pos;
}
