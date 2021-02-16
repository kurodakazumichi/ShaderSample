//-----------------------------------------------------------------------------
// 06_03 ValueNoise
//-----------------------------------------------------------------------------
Shader "Custom/Surface/ValueNoise"
{
	Properties{
		_MainTex("Albedo(RGB)", 2D) = "white" {}
		_Detail("Detail", Range(1, 100)) = 8
	}

		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM

			#pragma surface surf Standard fullforwardshadows
			#pragma target 3.0

			float _Detail;

			struct Input
			{
				float2 uv_MainTex;
			};

			float random(fixed2 p) {
				// この計算式はランダムノイズを作るときによく使われる計算式っぽい
				return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
			}

			float noise(fixed2 st) {
				fixed2 p = floor(st);
				fixed2 f = frac(st);

				float v00 = random(p + fixed2(0, 0));
				float v10 = random(p + fixed2(1, 0));
				float v01 = random(p + fixed2(0, 1));
				float v11 = random(p + fixed2(1, 1));

				// 0~1に向かって緩やかに補間する計算式
				// -2f^3 + 3f^2 = f^2 (-2f + 3) = f * f * (-2 * f + 3)
				fixed2 u = f * f * (-2.0 * f + 3.0);

				float v0010 = lerp(v00, v10, u.x);
				float v0111 = lerp(v01, v11, u.x);

				return lerp(v0010, v0111, u.y);
			}

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				float c = noise(IN.uv_MainTex * _Detail);
				o.Albedo = fixed4(c, c, c, 1);
				o.Metallic = 0;
				o.Smoothness = 0;
				o.Alpha = 1;
			}
			ENDCG
		}
}