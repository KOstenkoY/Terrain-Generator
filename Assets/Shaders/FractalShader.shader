Shader "Custom/FractalShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" { }
        _MaxIterations("Max Iterations", Range(1, 100)) = 50
        _Scale("Scale", Range(0.1, 10.0)) = 1.0
    }

        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 100

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma exclude_renderers gles xbox360 ps3

                struct appdata
                {
                    float4 vertex : POSITION;
                };

                struct v2f
                {
                    float4 pos : POSITION;
                };

                sampler2D _MainTex;
                int _MaxIterations;
                float _Scale;

                v2f vert(appdata v)
                {
                    v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    return o;
                }

                fixed4 frag(v2f i) : COLOR
                {
                    // Coordinates in the range [-1, 1]
                    float2 uv = i.pos.xy / i.pos.w;

                    // Map UV coordinates to the fractal space
                    uv *= _Scale;

                    // Implement a simple fractal algorithm (Mandelbrot set)
                    float2 c = uv;
                    float2 z = uv;
                    float iteration = 0.0;

                    for (int it = 0; it < _MaxIterations; ++it)
                    {
                        float xtemp = z.x * z.x - z.y * z.y + c.x;
                        z.y = 2.0 * z.x * z.y + c.y;
                        z.x = xtemp;

                        if (z.x * z.x + z.y * z.y > 4.0)
                        {
                            // Color based on the number of iterations
                            float normIterations = float(it) / float(_MaxIterations);
                            return tex2D(_MainTex, float2(normIterations, 0.5));
                        }
                    }

                    // If the point is inside the fractal, use a background color
                    return fixed4(0.0, 0.0, 0.0, 1.0);
                }
                ENDCG
            }
        }
}