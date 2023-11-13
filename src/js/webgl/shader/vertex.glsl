precision mediump float;

attribute vec3 position;
attribute vec2 uv;
attribute vec3 normal;

attribute float instanceIndex;
attribute float increaseValue;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

uniform float uTime;

uniform float polygonN;
uniform float placeRadius;

const float PI = 3.1415926535897932384626433832795;
const float PI2 = PI * 2.0;

vec2 getPolygonPos(float n, float t, float radius) {
  float h = 1.0;
  float an = PI2 / n;
  float a = an / 2.0;
  float b = t / an;

  float x = cos(a) * cos(t) / cos(an * (b - floor(b)) - a) * radius;

  float y = cos(a) * sin(t) / cos(an * (b - floor(b)) - a) * radius;

  return vec2(x, y);
}

vec2 getTrochoidPos(float n, float t, float radius) {
  float h = 1.0;

  float x = ((n - 1.0) * cos(t) + h * cos((n - 1.) * t) / n) * radius;
  float y = ((n - 1.0) * sin(t) - h * sin((n - 1.) * t) / n) * radius;

  return vec2(x, y);
}

void main() {
  vec3 pos = position;
  pos *= increaseValue;

  pos.xy += getPolygonPos(polygonN, uTime * 0.1, placeRadius);
  pos.xy += getTrochoidPos(polygonN, increaseValue * 0.1 + uTime, placeRadius);

  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(pos, 1.0);
}