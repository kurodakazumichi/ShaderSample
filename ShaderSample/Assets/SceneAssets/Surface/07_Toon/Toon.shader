//-----------------------------------------------------------------------------
// 07 Toon
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Toon"
{
	Properties{
		_Color("Color", Color) = (1, 1, 1 ,1)
		[NoScaleOffset] _MainTex("Albedo (RGB)", 2D) = "white" {}
		[NoScaleOffset] _RampTex("Ramp", 2D) = "white" {}
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf ToonRamp
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _RampTex;
		
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha  = c.a;
		}

		fixed4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten) {
			// 法線とライトの方向の内積を取ると-1.0 ~ 1.0の間になる
			// 最終的にuv座標として扱いたいので0.0 ~ 1.0の間に収めたい
			// その為、内積を 0.5倍する事で -0.5 ~ 0.5にし、そこに0.5を足している。
			half d = dot(s.Normal, lightDir) * 0.5 + 0.5;
			fixed3 ramp = tex2D(_RampTex, fixed2(d, 0.5)).rgb;
			fixed4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * ramp;
			c.a = 0;
			return c;
		}
		ENDCG
	}

	// 動くシェーダーがなかった時に使われるシェーダーを指定する。
	FallBack "Diffuse"
}