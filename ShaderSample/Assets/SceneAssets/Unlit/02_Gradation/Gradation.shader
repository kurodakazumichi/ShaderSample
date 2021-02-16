//-----------------------------------------------------------------------------
// 02 Gradation
//-----------------------------------------------------------------------------
Shader "Custom/Unlit/Gradation"
{
  Properties
  {
    _Displacement ("Displacement", Float) = 0
  }
    SubShader
  {
    Tags { "RenderType" = "Transparent" }
    Cull Off ZWrite On Blend SrcAlpha OneMinusSrcAlpha

    Pass
    {
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag

      #include "UnityCG.cginc"

      Float _Displacement;

      struct v2f
      {
        float4 pos : SV_POSITION;
        float3 worldPos : TEXCOORD0;
      };

      v2f vert (appdata_base v)
      {
        v2f o;

        // サイトはこの計算だったけど、法線の向きがいまいちだと変な結果になる
        //float3 n = UnityObjectToWorldNormal(v.normal);
        //o.pos = UnityObjectToClipPos(v.vertex) + float4(n * _Displacement, 0);

        // ワールド座標方向に伸ばした方が面白い
        o.pos = UnityObjectToClipPos(v.vertex);
        o.pos = o.pos + float4(normalize(o.pos.xyz) * _Displacement, 0);

        // これだとただのスケールなので面白くない。
        //o.pos = UnityObjectToClipPos(v.vertex + (normalize(v.vertex) * _Displacement));
        o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
        return o;
      }

      fixed4 frag(v2f i) : SV_Target
      {
        float4 pink = float4(1, 0, 1, 1);
        float4 blue = float4(0, 1, 1, 1);
        return lerp(blue, pink, i.worldPos.y * 0.2);
      }
      ENDCG
    }
  }
}
