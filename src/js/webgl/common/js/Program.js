'use strict'
import { utils } from './utils.js'

// Program constructor that takes a WebGL context and script tag IDs
// to extract vertex and fragment shader source code from the page
export class Program {
  constructor(gl, vertexShader, fragmentShader) {
    this.gl = gl
    this.program = gl.createProgram()

    if (!(vertexShader && fragmentShader)) {
      return console.error('No shader IDs were provided')
    }
    gl.attachShader(this.program, utils.getShader(gl, vertexShader, 'vertex'))
    gl.attachShader(this.program, utils.getShader(gl, fragmentShader, 'fragment'))
    gl.linkProgram(this.program)

    if (!this.gl.getProgramParameter(this.program, this.gl.LINK_STATUS)) {
      return console.error('Could not initialize shaders.')
    }

    this.useProgram()
  }

  // Sets the WebGL context to use current program
  useProgram() {
    this.gl.useProgram(this.program)
  }

  // Load up the given attributes and uniforms from the given values
  load(attributes, uniforms) {
    this.useProgram()
    this.setAttributeLocations(attributes)
    this.setUniformLocations(uniforms)
  }

  // Set references to attributes onto the program instance
  setAttributeLocations(attributes) {
    attributes.forEach((attribute) => {
      this[attribute] = this.gl.getAttribLocation(this.program, attribute)
    })
  }

  // Set references to uniforms onto the program instance
  setUniformLocations(uniforms) {
    uniforms.forEach((uniform) => {
      this[uniform] = this.gl.getUniformLocation(this.program, uniform)
    })
  }

  // Get the uniform location from the program
  getUniform(uniformLocation) {
    return this.gl.getUniform(this.program, uniformLocation)
  }
}
