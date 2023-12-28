Shader "Custom/AnaglyphShader"
{
    Properties
    {
        _MainTexL("Left Eye Texture", 2D) = "white" {}
        _MainTexR("Right Eye Texture", 2D) = "white" {}
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
                float2 uvL : TEXCOORD0;
                float2 uvR : TEXCOORD1;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float2 uvL : TEXCOORD0;
                float2 uvR : TEXCOORD1;
            };

            sampler2D _MainTexL;
            sampler2D _MainTexR;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uvL = v.uvL;
                o.uvR = v.uvR;
                return o;
            }

            fixed4 frag(v2f i) : COLOR
            {
                // Sample left and right eye textures
                fixed4 colL = tex2D(_MainTexL, i.uvL);
                fixed4 colR = tex2D(_MainTexR, i.uvR);

                // Combine colors for the anaglyph effect
                fixed4 finalColor;
                finalColor.r = colR.r;
                finalColor.g = colL.g;
                finalColor.b = colL.b;
                finalColor.a = max(colL.a, colR.a);

                return finalColor;
            }
            ENDCG
        }
    }
        FallBack "Diffuse"
}