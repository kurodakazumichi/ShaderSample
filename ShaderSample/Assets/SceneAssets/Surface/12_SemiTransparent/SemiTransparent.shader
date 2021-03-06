﻿//-----------------------------------------------------------------------------
// 12 SemiTransparent
// 半透明の奥側まで描画されてしまう問題を解決したシェーダー
//-----------------------------------------------------------------------------
Shader "Custom/Surface/SemiTransparent"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Albedo (RGB)", 2D) = "white" {}
    _Glossiness ("Smoothness", Range(0,1)) = 0.5
    _Metallic ("Metallic", Range(0,1)) = 0.0
  }

  SubShader
  {
    Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
    LOD 200

    Pass {
      ZWrite ON
      ColorMask 0
    }

    CGPROGRAM
    #pragma surface surf Standard fullforwardshadows alpha:fade
    #pragma target 3.0

    sampler2D _MainTex;
    half _Glossiness;
    half _Metallic;
    fixed4 _Color;

    struct Input
    {
      float2 uv_MainTex;
    };

    void surf (Input IN, inout SurfaceOutputStandard o)
    {
      fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
      o.Albedo = c.rgb;
      o.Metallic = _Metallic;
      o.Smoothness = _Glossiness;
      o.Alpha = c.a;
    }
    ENDCG
  }
  FallBack "Diffuse"
}
