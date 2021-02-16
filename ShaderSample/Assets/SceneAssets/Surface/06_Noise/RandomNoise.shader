//-----------------------------------------------------------------------------
// 06_01 RandomNoise
//-----------------------------------------------------------------------------
Shader "Custom/Surface/RandomNoise"
{
	Properties{
		_MainTex("Albedo(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		float random(fixed2 p) {
			// この計算式はランダムノイズを作るときによく使われる計算式っぽい
			return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
		}

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float c = random(IN.uv_MainTex);
			o.Albedo = fixed4(c, c, c, 1);
		}
		ENDCG
	}
}