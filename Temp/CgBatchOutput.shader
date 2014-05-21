Shader "Hedgehog Team/Vegetation-lightmap" {
Properties {
	_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
	_SecondaryFactor ("Factor for up and fown bending", float) = 2.5
}

SubShader {
	Tags {"Queue"="AlphaTest" "RenderType"="TransparentCutout" "LightMode"="ForwardBase"}
	LOD 100
	cull off
	AlphaTest Greater [_Cutoff]
	
	#LINE 92


	Pass {
		Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 41 to 41
//   d3d9 - ALU: 43 to 43
//   d3d11 - ALU: 33 to 33, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 33 to 33, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 9 [_Time]
Matrix 5 [_Object2World]
Vector 10 [_Wind]
Vector 11 [_MainTex_ST]
Vector 12 [unity_LightmapST]
Float 13 [_SecondaryFactor]
"!!ARBvp1.0
# 41 ALU
PARAM c[16] = { { -0.5, 0.30000001, 1, 2 },
		state.matrix.mvp,
		program.local[5..13],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 3, 0.1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R0.zw, vertex.position.xyxz, c[0].y;
MOV R0.x, c[0].z;
DP3 R0.x, R0.x, c[8];
ADD R1.xy, R0.zwzw, c[9].y;
ADD R0.z, vertex.color.y, R0.x;
MOV R0.y, R0.x;
DP3 R0.x, vertex.position, R0.z;
ADD R0.xy, R1, R0;
MUL R0, R0.xxyy, c[14];
FRC R0, R0;
MAD R0, R0, c[0].w, c[0].x;
FRC R0, R0;
MAD R0, R0, c[0].w, -c[0].z;
ABS R0, R0;
MUL R1, -R0, c[0].w;
ADD R1, R1, c[15].x;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R2.xy, R0.xzzw, R0.ywzw;
MUL R0.xyz, R2.y, c[10];
MUL R1.xyz, vertex.color.z, R0;
SLT R0.xy, c[15].z, vertex.normal.xzzw;
SLT R0.zw, vertex.normal.xyxz, c[15].z;
ADD R0.zw, R0.xyxy, -R0;
MUL R1.w, vertex.color.y, c[15].y;
MUL R0.xy, R1.w, vertex.normal.xzzw;
MUL R0.xz, R0.xyyw, R0.zyww;
MUL R1.w, vertex.color.x, c[13].x;
MUL R0.y, R1.w, c[0];
MAD R0.xyz, R2.xyxw, R0, R1;
MAD R1.xyz, R0, c[10].w, vertex.position;
MUL R0.xyz, vertex.color.z, c[10];
MOV R0.w, vertex.position;
MAD R0.xyz, R0, c[10].w, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 41 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Matrix 4 [_Object2World]
Vector 9 [_Wind]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
Float 12 [_SecondaryFactor]
"vs_2_0
; 43 ALU
def c13, 1.00000000, 0.30000001, 2.00000000, -0.50000000
def c14, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c15, 2.00000000, -1.00000000, 3.00000000, 0.10000000
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov r0.xyz, c7
dp3 r0.y, c13.x, r0
add r0.x, v4.y, r0.y
mul r0.zw, v0.xyxz, c13.y
add r0.zw, r0, c8.y
dp3 r0.x, v0, r0.x
add r0.xy, r0.zwzw, r0
mul r0, r0.xxyy, c14
frc r0, r0
mad r0, r0, c13.z, c13.w
frc r0, r0
mad r0, r0, c15.x, c15.y
abs r0, r0
mad r1, -r0, c15.x, c15.z
mul r0, r0, r0
mul r0, r0, r1
add r2.xy, r0.xzzw, r0.ywzw
mul r0.xyz, r2.y, c9
mul r1.xyz, v4.z, r0
slt r0.xy, -v1.xzzw, v1.xzzw
slt r0.zw, v1.xyxz, -v1.xyxz
sub r0.zw, r0.xyxy, r0
mul r1.w, v4.y, c15
mul r0.xy, r1.w, v1.xzzw
mul r0.xz, r0.xyyw, r0.zyww
mul r1.w, v4.x, c12.x
mul r0.y, r1.w, c13
mad r0.xyz, r2.xyxw, r0, r1
mad r1.xyz, r0, c9.w, v0
mul r0.xyz, v4.z, c9
mov r0.w, v0
mad r0.xyz, r0, c9.w, r1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov oD0, v4
mad oT0.xy, v2, c10, c10.zwzw
mad oT1.xy, v3, c11, c11.zwzw
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 96 // 84 used size, 6 vars
Vector 16 [_Wind] 4
Vector 32 [_MainTex_ST] 4
Vector 64 [unity_LightmapST] 4
Float 80 [_SecondaryFactor]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 39 instructions, 5 temp regs, 0 temp arrays:
// ALU 32 float, 1 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmfnjmfpojmgombobhfpkbieniacohjiaabaaaaaaiiahaaaaadaaaaaa
cmaaaaaapeaaaaaajiabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcoiafaaaa
eaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaaaaaaaaaadkiacaaa
acaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaaacaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaaaoaaaaaabaaaaaakccaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaafaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaaaaaaaakgakbaaaaaaaaaaadcaaaaanpcaabaaa
abaaaaaaagbkbaaaaaaaaaaaaceaaaaajkjjjjdojkjjjjdojkjjjjdojkjjjjdo
fgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaagafbaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
mnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaalp
bkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaaabaaaaaaegaobaia
ibaaaaaaaaaaaaaaegaobaiaibaaaaaaaaaaaaaadcaaaabapcaabaaaaaaaaaaa
egaobaiambaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaangafbaaa
aaaaaaaaigaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
kgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaagbibaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaa
acaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadiaaaaakmcaabaaaacaaaaaafgbbbaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaamnmmmmdnjkjjjjdodiaaaaahdcaabaaaadaaaaaa
kgakbaaaacaaaaaaigbabaaaacaaaaaadiaaaaaiccaabaaaaeaaaaaadkaabaaa
acaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaahfcaabaaaaeaaaaaaagabbaaa
acaaaaaaagabbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgipcaaaaaaaaaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaa
acaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
aeaaaaaakgiocaaaaaaaaaaaaeaaaaaadgaaaaafpccabaaaadaaaaaaegbobaaa
afaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying lowp vec4 xlv_COLOR;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _SecondaryFactor;
uniform highp vec4 unity_LightmapST;
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Wind;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 windParams_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = _glesColor.y;
  tmpvar_4.z = _glesColor.x;
  tmpvar_4.w = _glesColor.z;
  windParams_2 = tmpvar_4;
  highp vec4 pos_5;
  pos_5.w = _glesVertex.w;
  highp vec3 bend_6;
  vec4 v_7;
  v_7.x = _Object2World[0].w;
  v_7.y = _Object2World[1].w;
  v_7.z = _Object2World[2].w;
  v_7.w = _Object2World[3].w;
  float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, vec3(1.0, 1.0, 1.0));
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (_glesVertex.xyz, vec3((windParams_2.y + tmpvar_8)));
  tmpvar_9.y = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10 = abs(((fract((((fract((((_Time.yy + (_glesVertex.xz * 0.3)) + tmpvar_9).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0) + 0.5)) * 2.0) - 1.0));
  highp vec4 tmpvar_11;
  tmpvar_11 = ((tmpvar_10 * tmpvar_10) * (3.0 - (2.0 * tmpvar_10)));
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz + tmpvar_11.yw);
  bend_6.xz = (((windParams_2.y * 0.1) * tmpvar_1) * sign(tmpvar_1)).xz;
  bend_6.y = ((windParams_2.z * 0.3) * _SecondaryFactor);
  pos_5.xyz = (_glesVertex.xyz + (((tmpvar_12.xyx * bend_6) + ((_Wind.xyz * tmpvar_12.y) * windParams_2.w)) * _Wind.w));
  pos_5.xyz = (pos_5.xyz + ((windParams_2.w * _Wind.xyz) * _Wind.w));
  gl_Position = (glstate_matrix_mvp * pos_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  c_1.xyz = (tmpvar_2.xyz * xlv_COLOR.w);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (c_1.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying lowp vec4 xlv_COLOR;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _SecondaryFactor;
uniform highp vec4 unity_LightmapST;
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Wind;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 windParams_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = _glesColor.y;
  tmpvar_4.z = _glesColor.x;
  tmpvar_4.w = _glesColor.z;
  windParams_2 = tmpvar_4;
  highp vec4 pos_5;
  pos_5.w = _glesVertex.w;
  highp vec3 bend_6;
  vec4 v_7;
  v_7.x = _Object2World[0].w;
  v_7.y = _Object2World[1].w;
  v_7.z = _Object2World[2].w;
  v_7.w = _Object2World[3].w;
  float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, vec3(1.0, 1.0, 1.0));
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (_glesVertex.xyz, vec3((windParams_2.y + tmpvar_8)));
  tmpvar_9.y = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10 = abs(((fract((((fract((((_Time.yy + (_glesVertex.xz * 0.3)) + tmpvar_9).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0) + 0.5)) * 2.0) - 1.0));
  highp vec4 tmpvar_11;
  tmpvar_11 = ((tmpvar_10 * tmpvar_10) * (3.0 - (2.0 * tmpvar_10)));
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz + tmpvar_11.yw);
  bend_6.xz = (((windParams_2.y * 0.1) * tmpvar_1) * sign(tmpvar_1)).xz;
  bend_6.y = ((windParams_2.z * 0.3) * _SecondaryFactor);
  pos_5.xyz = (_glesVertex.xyz + (((tmpvar_12.xyx * bend_6) + ((_Wind.xyz * tmpvar_12.y) * windParams_2.w)) * _Wind.w));
  pos_5.xyz = (pos_5.xyz + ((windParams_2.w * _Wind.xyz) * _Wind.w));
  gl_Position = (glstate_matrix_mvp * pos_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float x_3;
  x_3 = (tmpvar_2.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  c_1.xyz = (tmpvar_2.xyz * xlv_COLOR.w);
  c_1.w = tmpvar_2.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c_1.xyz = (c_1.xyz * ((8.0 * tmpvar_4.w) * tmpvar_4.xyz));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Matrix 4 [_Object2World]
Vector 9 [_Wind]
Vector 10 [_MainTex_ST]
Vector 11 [unity_LightmapST]
Float 12 [_SecondaryFactor]
"agal_vs
c13 1.0 0.3 2.0 -0.5
c14 1.975 0.793 0.375 0.193
c15 2.0 -1.0 3.0 0.1
[bc]
aaaaaaaaaaaaahacahaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c7
bcaaaaaaaaaaacacanaaaaaaabaaaaaaaaaaaakeacaaaaaa dp3 r0.y, c13.x, r0.xyzz
abaaaaaaaaaaabacacaaaaffaaaaaaaaaaaaaaffacaaaaaa add r0.x, a2.y, r0.y
adaaaaaaaaaaamacaaaaaaieaaaaaaaaanaaaaffabaaaaaa mul r0.zw, a0.xyxz, c13.y
abaaaaaaaaaaamacaaaaaaopacaaaaaaaiaaaaffabaaaaaa add r0.zw, r0.wwzw, c8.y
bcaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaaaacaaaaaa dp3 r0.x, a0, r0.x
abaaaaaaaaaaadacaaaaaapoacaaaaaaaaaaaafeacaaaaaa add r0.xy, r0.zwww, r0.xyyy
adaaaaaaaaaaapacaaaaaafaacaaaaaaaoaaaaoeabaaaaaa mul r0, r0.xxyy, c14
aiaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa frc r0, r0
adaaaaaaaaaaapacaaaaaaoeacaaaaaaanaaaakkabaaaaaa mul r0, r0, c13.z
abaaaaaaaaaaapacaaaaaaoeacaaaaaaanaaaappabaaaaaa add r0, r0, c13.w
aiaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa frc r0, r0
adaaaaaaaaaaapacaaaaaaoeacaaaaaaapaaaaaaabaaaaaa mul r0, r0, c15.x
abaaaaaaaaaaapacaaaaaaoeacaaaaaaapaaaaffabaaaaaa add r0, r0, c15.y
beaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa abs r0, r0
bfaaaaaaabaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa neg r1, r0
adaaaaaaabaaapacabaaaaoeacaaaaaaapaaaaaaabaaaaaa mul r1, r1, c15.x
abaaaaaaabaaapacabaaaaoeacaaaaaaapaaaakkabaaaaaa add r1, r1, c15.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r0, r0, r0
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaacaaadacaaaaaakiacaaaaaaaaaaaapnacaaaaaa add r2.xy, r0.xzzz, r0.ywww
adaaaaaaaaaaahacacaaaaffacaaaaaaajaaaaoeabaaaaaa mul r0.xyz, r2.y, c9
adaaaaaaabaaahacacaaaakkaaaaaaaaaaaaaakeacaaaaaa mul r1.xyz, a2.z, r0.xyzz
bfaaaaaaacaaamacabaaaaoiaaaaaaaaaaaaaaaaaaaaaaaa neg r2.zw, a1.xzzw
ckaaaaaaaaaaadacacaaaapoacaaaaaaabaaaaoiaaaaaaaa slt r0.xy, r2.zwww, a1.xzzw
bfaaaaaaadaaafacabaaaaieaaaaaaaaaaaaaaaaaaaaaaaa neg r3.xz, a1.xyxz
ckaaaaaaaaaaamacabaaaaieaaaaaaaaadaaaaikacaaaaaa slt r0.zw, a1.xyxz, r3.zzxz
acaaaaaaaaaaamacaaaaaaefacaaaaaaaaaaaaopacaaaaaa sub r0.zw, r0.yyxy, r0.wwzw
adaaaaaaabaaaiacacaaaaffaaaaaaaaapaaaaoeabaaaaaa mul r1.w, a2.y, c15
adaaaaaaaaaaadacabaaaappacaaaaaaabaaaaoiaaaaaaaa mul r0.xy, r1.w, a1.xzzw
adaaaaaaaaaaafacaaaaaafeacaaaaaaaaaaaapoacaaaaaa mul r0.xz, r0.xyyy, r0.zwww
adaaaaaaabaaaiacacaaaaaaaaaaaaaaamaaaaaaabaaaaaa mul r1.w, a2.x, c12.x
adaaaaaaaaaaacacabaaaappacaaaaaaanaaaaoeabaaaaaa mul r0.y, r1.w, c13
adaaaaaaaaaaahacacaaaaaeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyxx, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaajaaaappabaaaaaa mul r1.xyz, r0.xyzz, c9.w
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa add r1.xyz, r1.xyzz, a0
adaaaaaaaaaaahacacaaaakkaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a2.z, c9
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
adaaaaaaaaaaahacaaaaaakeacaaaaaaajaaaappabaaaaaa mul r0.xyz, r0.xyzz, c9.w
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 o0.w, r0, c3
bdaaaaaaaaaaaeadaaaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 o0.z, r0, c2
bdaaaaaaaaaaacadaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 o0.y, r0, c1
bdaaaaaaaaaaabadaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, r0, c0
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaadaaadacadaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r3.xy, a3, c10
abaaaaaaaaaaadaeadaaaafeacaaaaaaakaaaaooabaaaaaa add v0.xy, r3.xyyy, c10.zwzw
adaaaaaaadaaadacaeaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r3.xy, a4, c11
abaaaaaaabaaadaeadaaaafeacaaaaaaalaaaaooabaaaaaa add v1.xy, r3.xyyy, c11.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 96 // 84 used size, 6 vars
Vector 16 [_Wind] 4
Vector 32 [_MainTex_ST] 4
Vector 64 [unity_LightmapST] 4
Float 80 [_SecondaryFactor]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 39 instructions, 5 temp regs, 0 temp arrays:
// ALU 32 float, 1 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedpgadkipcgpioghbeinhhemcmecjonaaaabaaaaaadmalaaaaaeaaaaaa
daaaaaaaoaadaaaanaajaaaajiakaaaaebgpgodjkiadaaaakiadaaaaaaacpopp
eeadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaabaa
acaaabaaaaaaaaaaaaaaaeaaacaaadaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaa
acaaaaaaaeaaagaaaaaaaaaaacaaamaaadaaakaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafanaaapkaaaaaiadpjkjjjjdoaaaaaaeaaaaaaalpfbaaaaafaoaaapka
mnmmpmdpamaceldpaaaamadomlkbefdofbaaaaafapaaapkaaaaaaaeaaaaaialp
aaaaeaeaaaaaaaaafbaaaaafbaaaapkamnmmmmdnjkjjjjdoaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaacafaaafiaafaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaaeaabejaadaabeka
adaalekaabaaaaacaaaaabiaakaappkaabaaaaacaaaaaciaalaappkaabaaaaac
aaaaaeiaamaappkaaiaaaaadaaaaaciaaaaaoeiaanaaaakaacaaaaadaaaaaeia
aaaaffiaafaaffjaaiaaaaadaaaaabiaaaaaoejaaaaakkiaabaaaaacabaaacia
anaaffkaaeaaaaaeabaaapiaaaaakajaabaaffiaafaaffkaacaaaaadaaaaapia
aaaafaiaabaaoeiaafaaaaadaaaaapiaaaaaoeiaaoaaoekabdaaaaacaaaaapia
aaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaanaakkkaanaappkabdaaaaacaaaaapia
aaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaapaaaakaapaaffkacdaaaaacaaaaapia
aaaaoeiaafaaaaadabaaapiaaaaaoeiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
apaaaakbapaakkkaafaaaaadaaaaapiaaaaaoeiaabaaoeiaacaaaaadaaaaahia
aaaanniaaaaamiiaafaaaaadabaaahiaaaaaffiaabaaoekaafaaaaadabaaahia
abaaoeiaafaakkjaamaaaaadacaaadiaacaaoijbacaaoijaamaaaaadacaaamia
acaaiejaacaaiejbacaaaaadacaaadiaacaaooibacaaoeiaafaaaaadacaaamia
afaabejabaaaeekaafaaaaadadaaadiaacaakkiaacaaoijaafaaaaadaeaaacia
acaappiaaeaaaakaafaaaaadaeaaafiaacaaneiaadaaneiaaeaaaaaeaaaaahia
aaaaoeiaaeaaoeiaabaaoeiaaeaaaaaeaaaaahiaaaaaoeiaabaappkaaaaaoeja
afaaaaadabaaahiaafaakkjaabaaoekaaeaaaaaeaaaaahiaabaaoeiaabaappka
aaaaoeiaafaaaaadabaaapiaaaaaffiaahaaoekaaeaaaaaeabaaapiaagaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaapoaafaaoejappppaaaa
fdeieefcoiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadfcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacafaaaaaadgaaaaagbcaabaaa
aaaaaaaadkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaadkiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaacaaaaaaaoaaaaaa
baaaaaakccaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaaaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
afaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaakgakbaaaaaaaaaaa
dcaaaaanpcaabaaaabaaaaaaagbkbaaaaaaaaaaaaceaaaaajkjjjjdojkjjjjdo
jkjjjjdojkjjjjdofgifcaaaabaaaaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaa
agafbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaamnmmpmdpamaceldpaaaamadomlkbefdobkaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpbkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdiaaaaajpcaabaaa
abaaaaaaegaobaiaibaaaaaaaaaaaaaaegaobaiaibaaaaaaaaaaaaaadcaaaaba
pcaabaaaaaaaaaaaegaobaiambaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaeaeadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaa
aaaaaaaangafbaaaaaaaaaaaigaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaakgbkbaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaigbabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaagbibaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaakmcaabaaaacaaaaaa
fgbbbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaamnmmmmdnjkjjjjdodiaaaaah
dcaabaaaadaaaaaakgakbaaaacaaaaaaigbabaaaacaaaaaadiaaaaaiccaabaaa
aeaaaaaadkaabaaaacaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaahfcaabaaa
aeaaaaaaagabbaaaacaaaaaaagabbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaaabaaaaaaegbcbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgbkbaaaafaaaaaaegiccaaaaaaaaaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaa
ogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadgaaaaafpccabaaa
adaaaaaaegbobaaaafaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahafaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapapaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojmaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahapaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 511
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec2 lmap;
    lowp vec3 spec;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 505
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform lowp float _Cutoff;
uniform highp vec4 unity_LightmapST;
#line 509
uniform sampler2D unity_Lightmap;
uniform highp float _SecondaryFactor;
#line 520
#line 537
#line 447
highp vec4 SmoothCurve( in highp vec4 x ) {
    #line 449
    return ((x * x) * (3.0 - (2.0 * x)));
}
#line 451
highp vec4 TriangleWave( in highp vec4 x ) {
    #line 453
    return abs(((fract((x + 0.5)) * 2.0) - 1.0));
}
#line 455
highp vec4 SmoothTriangleWave( in highp vec4 x ) {
    #line 457
    return SmoothCurve( TriangleWave( x));
}
#line 520
highp vec4 AnimateVertex2( in highp vec4 pos, in highp vec3 normal, in highp vec4 animParams, in highp float SecondaryFactor ) {
    highp float fDetailAmp = 0.1;
    highp float fBranchAmp = 0.3;
    #line 524
    highp float fObjPhase = dot( xll_matrixindex_mf4x4_i (_Object2World, 3).xyz, vec3( 1.0));
    highp float fBranchPhase = fObjPhase;
    highp float fVtxPhase = dot( pos.xyz, vec3( (animParams.y + fBranchPhase)));
    highp vec2 vWavesIn = ((_Time.yy + (pos.xz * 0.3)) + vec2( fVtxPhase, fBranchPhase));
    #line 528
    highp vec4 vWaves = ((fract((vWavesIn.xxyy * vec4( 1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0);
    vWaves = SmoothTriangleWave( vWaves);
    highp vec2 vWavesSum = (vWaves.xz + vWaves.yw);
    highp vec3 bend = (((animParams.y * fDetailAmp) * normal.xyz) * sign(normal.xyz));
    #line 532
    bend.y = ((animParams.z * fBranchAmp) * SecondaryFactor);
    pos.xyz += (((vWavesSum.xyx * bend) + ((_Wind.xyz * vWavesSum.y) * animParams.w)) * _Wind.w);
    pos.xyz += ((animParams.w * _Wind.xyz) * _Wind.w);
    return pos;
}
#line 537
v2f vert( in appdata_full v ) {
    v2f o;
    highp vec4 windParams = vec4( 0.0, v.color.y, v.color.x, v.color.z);
    #line 541
    highp vec4 mdlPos = AnimateVertex2( v.vertex, v.normal, windParams, _SecondaryFactor);
    o.pos = (glstate_matrix_mvp * mdlPos);
    o.uv = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.lmap = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 545
    o.color.xyzw = v.color.xyzw;
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main() {
    v2f xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
    xlv_TEXCOORD2 = vec3(xl_retval.spec);
    xlv_COLOR = vec4(xl_retval.color);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 511
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec2 lmap;
    lowp vec3 spec;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 505
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform lowp float _Cutoff;
uniform highp vec4 unity_LightmapST;
#line 509
uniform sampler2D unity_Lightmap;
uniform highp float _SecondaryFactor;
#line 520
#line 537
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 548
lowp vec4 frag( in v2f i ) {
    #line 550
    lowp vec4 tex = texture( _MainTex, i.uv);
    xll_clip_f((tex.w - _Cutoff));
    lowp vec4 c;
    c.xyz = (tex.xyz * i.color.w);
    #line 554
    c.w = tex.w;
    lowp vec3 lm = DecodeLightmap( texture( unity_Lightmap, i.lmap));
    c.xyz *= lm;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xlt_i.lmap = vec2(xlv_TEXCOORD1);
    xlt_i.spec = vec3(xlv_TEXCOORD2);
    xlt_i.color = vec4(xlv_COLOR);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 9 to 9, TEX: 2 to 2
//   d3d9 - ALU: 9 to 9, TEX: 3 to 3
//   d3d11 - ALU: 6 to 6, TEX: 2 to 2, FLOW: 1 to 1
//   d3d11_9x - ALU: 6 to 6, TEX: 2 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 9 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[0];
MUL R0.xyz, R0, fragment.color.primary.w;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[1].x;
END
# 9 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1.xy
dcl v0.xyzw
texld r1, t0, s0
add_pp r0.x, r1.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r2, -r0.x
mul_pp r1.xyz, r1, v0.w
texld r0, t1, s1
texkill r2.xyzw
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mul_pp r0.xyz, r0, c1.z
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 96 // 52 used size, 6 vars
Float 48 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedknnbmlmmklbpldnbablmmakehngmgaanabaaaaaalaacaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaajfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadicbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaadaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaadaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "flash " {
Keywords { }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"agal_ps
c1 0.0 1.0 8.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
acaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaoeabaaaaaa sub r0.x, r1.w, c0
ckaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaaaabaaaaaa slt r0.x, r0.x, c1.x
bfaaaaaaacaaapacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2, r0.x
adaaaaaaabaaahacabaaaakeacaaaaaaahaaaappaeaaaaaa mul r1.xyz, r1.xyzz, v7.w
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v1, s1 <2d wrap linear point>
chaaaaaaaaaaaaaaacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa kil a0.none, r2.x
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakkabaaaaaa mul r0.xyz, r0.xyzz, c1.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { }
ConstBuffer "$Globals" 96 // 52 used size, 6 vars
Float 48 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedjebhonenenbillljkjicfgapoojkamllabaaaaaaneadaaaaaeaaaaaa
daaaaaaafaabaaaapmacaaaakaadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
oaaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaadaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
acaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappiaaaaaaakbabaaaaac
acaaadiaaaaabllaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
afaaaaadabaaciiaabaappiaabaaaakaafaaaaadabaachiaabaaoeiaabaappia
afaaaaadacaachiaaaaaoeiaacaapplaafaaaaadaaaachiaabaaoeiaacaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckeabaaaaeaaaaaaagjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gcbaaaadicbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaaaaaajfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 115
 
	}	
}
}
