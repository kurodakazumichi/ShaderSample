Shader "Custom/Surface/SimpleLambert"
{
  SubShader
  {
    Tags { "RenderType"="Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf SimpleLambert
    #pragma target 3.0

    struct Input
    {
      float2 uv_MainTex;
    };

    void surf (Input IN, inout SurfaceOutput o)
    {
      o.Albedo = fixed4(1, 1, 1, 1);
    }

    half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) {
      half d = max(0, dot(s.Normal, lightDir));
      fixed4 c;
      // 物体の色 * ライトの色 * 内積 + 環境光色
      c.rgb = s.Albedo * _LightColor0.rgb * d + fixed4(0.2f, 0.2f, 0.2f, 1);
      c.a = s.Alpha;
      return c;
    }
    ENDCG
  }
  FallBack "Diffuse"
}
