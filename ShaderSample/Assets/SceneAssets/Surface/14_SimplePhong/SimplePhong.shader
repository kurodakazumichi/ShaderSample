//-----------------------------------------------------------------------------
// 14 SimplePhong
// てっかてか感のあるシェーダー
//-----------------------------------------------------------------------------
Shader "Custom/Surface/SimplePhong"
{
  Properties{
    _Spec("Spec", Range(0, 100)) = 0.0
  }
  
  SubShader
  {
    Tags { "RenderType" = "Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf SimplePhong
    #pragma target 3.0

    float _Spec;

    struct Input
    {
      float2 uv_MainTex;
    };

    void surf (Input IN, inout SurfaceOutput o)
    {
      o.Albedo = fixed4(1, 1, 1, 1);
    }

    half4 LightingSimplePhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) 
    {
      // 法線とライトの方向の内積を取得
      // この時点でmax(0, dot)のように内積の値を0~1にしてしまうと反射ベクトルが正しく計算できないので注意
      half d = dot(s.Normal, lightDir);

      // 反射ベクトルを計算
      float3 R = normalize(-lightDir + 2.0 * s.Normal * d);

      // 反射ベクトルと視線ベクトルの角度から反射光の強さを決める
      // 内積がマイナス=ライトから見て陰になる部分なので0~1に収める
      float3 spec = pow(max(0, dot(R, viewDir)), _Spec);

      half4 c;
      c.rgb = s.Albedo * (_LightColor0.rgb * max(0, d)) + spec + fixed4(0.1f, 0.1f, 0.1f, 1);
      c.a = s.Alpha;
      
      return c;
    }
    ENDCG
  }
  FallBack "Diffuse"
}
