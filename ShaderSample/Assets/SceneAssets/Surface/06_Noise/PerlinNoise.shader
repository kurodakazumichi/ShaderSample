//-----------------------------------------------------------------------------
// 06_04 PerlinNoise
//-----------------------------------------------------------------------------
Shader "Custom/Surface/PerlinNoise"
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

			float random(fixed2 st) {
				// 適当なランダムなベクトルを生成して返す
				st = fixed2(dot(st, fixed2(127.1, 311.7)), dot(st, fixed2(265.5, 183.3)));
				return -1.0 + 2.0 * frac(sin(st) * 43758.5453);
			}

			float noise(fixed2 st) {
				fixed2 p = floor(st);
				fixed2 f = frac(st);
				fixed2 u = f * f * (-2.0 * f + 3.0);

				float v00 = random(p + fixed2(0, 0));
				float v10 = random(p + fixed2(1, 0));
				float v01 = random(p + fixed2(0, 1));
				float v11 = random(p + fixed2(1, 1));

				// randomなベクトルと、格子内の座標から端点へ向かうベクトルの内積を使って色を決める
				float v0010 = lerp(dot(v00, f - fixed2(0, 0)), dot(v10, f - fixed2(1, 0)), u.x);
				float v0111 = lerp(dot(v01, f - fixed2(0, 1)), dot(v11, f - fixed2(1, 1)), u.x);

				return lerp(v0010, v0111, u.y) + 0.5f;
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