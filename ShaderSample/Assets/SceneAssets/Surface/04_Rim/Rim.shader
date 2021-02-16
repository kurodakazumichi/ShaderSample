//-----------------------------------------------------------------------------
// 04 Rimライティング
// 後光がさしてるようなシェーダー
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Rim"
{
	Properties{
		_MainTex("MainTex", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
		_RimColor("RimColor", Color) = (1, 1, 1, 1)
		_RimPower("RimPower", Range(0, 10)) = 0
	}

		SubShader
		{
			Tags { "RenderType"="Opaque" }
			LOD 200

			CGPROGRAM

			#pragma surface surf Standard
			#pragma target 3.0

			sampler2D _MainTex;
			fixed4 _BaseColor;
			fixed4 _RimColor;
			float _RimPower;

			struct Input
			{
				float2 uv_MainTex;
				float3 worldNormal;
				float3 viewDir;
			};

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _BaseColor;
				float rim = 1 - abs(dot(IN.viewDir, IN.worldNormal));
				o.Emission = _RimColor * pow(rim, _RimPower);
			}
			ENDCG
		}

		// 動くシェーダーがなかった時に使われるシェーダーを指定する。
		FallBack "Diffuse"
}