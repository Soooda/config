// Snow overlay for Ghostty.
// Soft depth-layered snowfall with wind shear, focus pulse, and per-flake twinkle.
// Optimized: division-free hash, cheaper distance metric, fewer layers.

#define LAYERS 28
#define DEPTH 0.42
#define WIDTH 0.20
#define SPEED 0.46
#define BRIGHTNESS 0.62

// Hash without sine (Dave Hoskins). Replaces the original mat3 hash,
// which cost a matrix multiply and three divisions per layer.
vec3 hash33(vec3 p3)
{
    p3 = fract(p3 * vec3(0.1031, 0.1030, 0.0973));
    p3 += dot(p3, p3.yxz + 33.33);
    return fract((p3.xxy + p3.yxx) * p3.zyx);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec3 acc = vec3(0.0);
    float dof = 5.0 * sin(iTime * 0.10);

    for (int i = 0; i < LAYERS; ++i) {
        float fi = float(i);
        float depth = 1.0 + fi * DEPTH;
        float fade = 1.0 + fi * DEPTH * 0.03;

        vec2 q = -uv * depth;
        q.x += q.y * (WIDTH * (fract(fi * 0.61803) - 0.5));
        q.y += SPEED * iTime / fade;

        vec3 r = hash33(vec3(floor(q), 17.31 + fi));

        // Per-flake twinkle: triangle wave with unique frequency and phase.
        float twinkle = 0.75 + 0.25 * abs(fract(iTime * (0.4 + 0.6 * r.z) + r.y) * 2.0 - 1.0);

        vec2 center = 0.5 + (r.xy - 0.5) * vec2(0.78, 0.92);
        vec2 s = abs(fract(q) - center);
        s += 0.008 * abs(2.0 * fract(8.0 * q.yx) - 1.0);

        float d = 0.58 * (s.x + s.y) + max(s.x, s.y) - 0.012;
        float edge = 0.004 + 0.035 * min(0.5 * abs(fi - 6.0 - dof), 1.0);
        float flake = 1.0 - smoothstep(-edge, edge, d);
        float weight = r.z * twinkle / fade;

        acc += vec3(flake * weight);
    }

    vec4 terminalColor = texture(iChannel0, uv);
    float luma = dot(terminalColor.rgb, vec3(0.2126, 0.7152, 0.0722));
    vec3 snow = acc * BRIGHTNESS * vec3(0.90, 0.94, 1.0);
    vec3 lift = snow * (0.78 + 0.22 * (1.0 - luma));
    vec3 blended = min(terminalColor.rgb + lift, vec3(1.0));

    fragColor = vec4(blended, terminalColor.a);
}
