//-----------------------------------------------------------------------------
// 03 Glass
// ガラスのようなシェーダー
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Glass"
{
	Properties{
		_MainTex("MainTex", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Transparency ("Transparency", Range(0, 10)) = 1
	}

		SubShader
	{
		Tags { "Queue" = "Transparent" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard alpha:fade
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _BaseColor;
		half _Glossiness;
		half _Metallic;
		float _Transparency;

		struct Input
		{
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _BaseColor;
			float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
			o.Alpha = pow(alpha, _Transparency);
			o.Smoothness = _Glossiness;
			o.Metallic = _Metallic;
		}
		ENDCG
	}

	// 動くシェーダーがなかった時に使われるシェーダーを指定する。
	FallBack "Diffuse"
}