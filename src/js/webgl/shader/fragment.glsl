precision mediump float;

varying float vIndex;

uniform float uXaspect;
uniform float uYaspect;
uniform float uTime;

uniform sampler2D uTexture;

void main() {
  gl_FragColor = vec4(sin(vIndex * uTime * 0.01), 0.5, 0.5, 1.0);
}