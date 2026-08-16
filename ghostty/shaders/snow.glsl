// Snow overlay for Ghostty.
// Based on the original working shader, with softer density and a more restrained blend.

#define LAYERS 42
#define DEPTH 0.42
#define WIDTH 0.20
#define SPEED 0.46
#define BRIGHTNESS 0.62

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    const mat3 p = mat3(
        13.323122, 23.5112, 21.71123,
        21.1212, 28.7312, 11.9312,
        21.8112, 14.7212, 61.3934
    );

    vec2 uv = fragCoord.xy / iResolution.xy;
    vec3 acc = vec3(0.0);
    float dof = 5.0 * sin(iTime * 0.10);

    for (int i = 0; i < LAYERS; ++i) {
        float fi = float(i);
        vec2 q = -uv * (1.0 + fi * DEPTH);
        q += vec2(
            q.y * (WIDTH * mod(fi * 7.238917, 1.0) - WIDTH * 0.5),
            SPEED * iTime / (1.0 + fi * DEPTH * 0.03)
        );

        vec3 n = vec3(floor(q), 31.189 + fi);
        vec3 m = floor(n) * 0.00001 + fract(n);
        vec3 mp = (31415.9 + m) / (fract(p * m) + 0.00001);
        vec3 r = fract(mp);

        vec2 center = 0.5 + (r.xy - 0.5) * vec2(0.78, 0.92);
        vec2 s = abs(fract(q) - center);
        s += 0.008 * abs(2.0 * fract(8.0 * q.yx) - 1.0);

        float d = 0.58 * max(s.x - s.y, s.x + s.y) + max(s.x, s.y) - 0.012;
        float edge = 0.004 + 0.035 * min(0.5 * abs(fi - 6.0 - dof), 1.0);
        float flake = smoothstep(edge, -edge, d);
        float layerWeight = r.x / (1.0 + 0.03 * fi * DEPTH);

        acc += vec3(flake * layerWeight);
    }

    vec4 terminalColor = texture(iChannel0, uv);
    float luma = dot(terminalColor.rgb, vec3(0.2126, 0.7152, 0.0722));
    vec3 snow = acc * BRIGHTNESS * vec3(0.90, 0.94, 1.0);
    vec3 lift = snow * (0.78 + 0.22 * (1.0 - luma));
    vec3 blended = min(terminalColor.rgb + lift, vec3(1.0));

    fragColor = vec4(blended, terminalColor.a);
}
