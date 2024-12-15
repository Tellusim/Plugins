// MIT License
// 
// Copyright (C) 2018-2024, Tellusim Technologies Inc. https://tellusim.com/
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#version 430 core

/*
 */
#if VERTEX_SHADER
	
	layout(binding = 0) uniform CommonParameters {
		float aspect;
		float time;
	};
	
	layout(location = 0) out vec2 s_texcoord;
	
	/*
	 */
	void main() {
		
		float height = 2.0f * sqrt(5.0f);
		vec2 position = vec2(0.0f, height);
		if(gl_VertexIndex == 0) position = vec2(-sqrt(15.0f), -sqrt(5.0f));
		if(gl_VertexIndex == 1) position = vec2( sqrt(15.0f), -sqrt(5.0f));
		position /= height;
		
		gl_Position.x = (sin(time) * position.x - cos(time) * position.y) / aspect;
		gl_Position.y = (cos(time) * position.x + sin(time) * position.y);
		gl_Position.z = 0.0f;
		gl_Position.w = 1.0f;
		
		s_texcoord = position + 0.5f;
	}
	
#elif FRAGMENT_SHADER
	
	layout(location = 0) in vec2 s_texcoord;
	
	layout(location = 0) out vec4 out_color;
	
	/*
	 */
	void main() {
		out_color = vec4(s_texcoord, 1.0f - s_texcoord.x - s_texcoord.y, 1.0f);
	}
	
#endif
