precision mediump float;

varying vec2 vUv;

uniform float uXaspect;
uniform float uYaspect;

uniform sampler2D uTexture;

void main() {
  gl_FragColor = vec4(0.74, 1.0, 0.5, 1.0);
}