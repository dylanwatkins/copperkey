Shader "Custom/ItemGlow" {
	Properties {
		_ColorTint ("Color Tine", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_RimColor ("Rim Color", Color) = (1,1,1,1)
		_RimPower ("Rim Power", Range(1.0, 6.0)) = 3.0 
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		// surface shader with errors was here
Pass { }
/*// error compiling initial surface function 'surf':
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
#include "Lighting.cginc"
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal
#line 1
#line 13

		#pragma surface surf Lambert


		struct Input {
			float4 color : Color;
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};
		
		float4 _ColorTint;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		float _RimColor;
		float _RimPower;

		void surf (Input IN, inout SurfaceOutput o) {
			IN.color = _ColorTint;
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * IN.color;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
		}
		
*/
#LINE 37

	} 
	FallBack "Diffuse"
}
