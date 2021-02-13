//-----------------------------------------------------------------------------
// 09 Dissolve
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Dissolve"
{
	Properties{
		_Color("Color", Color) = (1, 1, 1 ,1)
		[NoScaleOffset] _MainTex("Albedo (RGB)", 2D) = "white" {}
		[NoScaleOffset] _DissolveTex("DissolveTex(RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_Metallic ("Metallic", Range(0, 1)) = 0.0
		_Threshold("Threshold", Range(0, 1)) = 0.0
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _DissolveTex;
		half _Glossiness;
		half _Metallic;
		half _Threshold;
		
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 m = tex2D(_DissolveTex, IN.uv_MainTex);
			half g = m.r * 0.3 + m.g * 0.6 + m.b * 0.1;
			if (g < _Threshold) {
				discard;
			}
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}

		ENDCG
	}

		// 動くシェーダーがなかった時に使われるシェーダーを指定する。
			FallBack "Diffuse"
}