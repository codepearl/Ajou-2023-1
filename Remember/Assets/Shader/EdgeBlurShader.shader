Shader "Unlit/InsideTextureShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{

		Tags { "RenderType" = "Opaque" }

		Cull Front

		CGPROGRAM

		#pragma surface surf Lambert vertex:vert
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
			float4 color : COLOR;
		};


		void vert(inout appdata_full v)
		{
			v.normal.xyz = v.normal * -1;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed3 result = tex2D(_MainTex, IN.uv_MainTex);
			float4 sum = float4(0.0, 0.0, 0.0, 0.0);

			float blur = radius / resolution / 4;

			sum += tex2D(_MainTex, float2(tc.x - 4.0 * blur * hstep, tc.y - 4.0 * blur * vstep)) * 0.0162162162;
			sum += tex2D(_MainTex, float2(tc.x - 3.0 * blur * hstep, tc.y - 3.0 * blur * vstep)) * 0.0540540541;
			sum += tex2D(_MainTex, float2(tc.x - 2.0 * blur * hstep, tc.y - 2.0 * blur * vstep)) * 0.1216216216;
			sum += tex2D(_MainTex, float2(tc.x - 1.0 * blur * hstep, tc.y - 1.0 * blur * vstep)) * 0.1945945946;

			sum += tex2D(_MainTex, float2(tc.x, tc.y)) * 0.2270270270;

			sum += tex2D(_MainTex, float2(tc.x + 1.0 * blur * hstep, tc.y + 1.0 * blur * vstep)) * 0.1945945946;
			sum += tex2D(_MainTex, float2(tc.x + 2.0 * blur * hstep, tc.y + 2.0 * blur * vstep)) * 0.1216216216;
			sum += tex2D(_MainTex, float2(tc.x + 3.0 * blur * hstep, tc.y + 3.0 * blur * vstep)) * 0.0540540541;
			sum += tex2D(_MainTex, float2(tc.x + 4.0 * blur * hstep, tc.y + 4.0 * blur * vstep)) * 0.0162162162;
			
			o.Albedo = sum.rgb;
			o.Alpha = 1;
		}

		ENDCG

	}

		Fallback "Diffuse"
}

