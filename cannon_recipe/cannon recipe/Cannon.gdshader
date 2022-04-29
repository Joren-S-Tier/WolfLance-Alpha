shader_type spatial;
render_mode cull_disabled, unshaded;

uniform vec3 velocity = vec3(0.0 , 10.0, -15.0);
uniform float gravity = 9.8;


void vertex(){
	VERTEX.x = 0.0;
	VERTEX.y = VERTEX.z;
	VERTEX.z = 0.0;
	 
	VERTEX += velocity * UV.x;
	
	VERTEX.y -= gravity *UV.x * UV.x;
	
}