//-----------------------------------------------------------------------------
// 01 Basic
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Lambert"
{
	Properties{
		_BaseColor("Base Color", Color) = (1, 1, 1, 1)
		_Emission("Emision", Color) = (0, 0, 0, 0)
		_Specular("Specular", Range(0, 1)) = 0
		_Gloss("Gloss", Range(0, 1)) = 0
		_Alpha("Alpha", Range(0, 1)) = 1
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Lambert alpha:fade
		#pragma target 3.0

		fixed4 _Emission;
		fixed4 _BaseColor;
		half _Specular;
		fixed _Gloss;
		fixed _Alpha;

		struct Input
		{
				float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			// 基本の色
			o.Albedo = _BaseColor.rgb;
			// ライティング関係なく放出する色
			o.Emission = _Emission.xyz;

			// この２つのパラメータを反映させるにはほかにも設定が必要っぽい
			// 何が必要なのかは不明
			o.Specular = _Specular;
			o.Gloss = _Gloss;

			// alpha:fadeを指定しないと効果なし
			o.Alpha = _Alpha;
		}
	ENDCG
	}

	FallBack "Diffuse"
}