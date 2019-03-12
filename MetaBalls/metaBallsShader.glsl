#define PROCESSING_COLOR_SHADER//needed for Processing3

uniform vec2 resolution;

uniform vec2 location_Ball_One;
uniform vec2 location_Ball_Two;
uniform vec2 location_Ball_Three;
uniform vec2 location_Ball_Four;
uniform vec2 location_Ball_Five;

uniform vec4 color_Ball_One;
uniform vec4 color_Ball_Two;
uniform vec4 color_Ball_Three;
uniform vec4 color_Ball_Four;
uniform vec4 color_Ball_Five;

uniform float threshold;
uniform float size;

void main(void) {//loops once per pixel
  vec4 pixelColor = vec4(0.0, 0.0, 0.0, 1.0);//start with a black pixel

  float aspectRatio = resolution.x/resolution.y;//to adjust distance calculation
  vec2 position = gl_FragCoord.xy/resolution.xy;//scaled position
  vec2 center = vec2(0.5, 0.5);//no longer used, but keeping it for clarity
    
  //calculat distance from pixel to center of each metaball. adjust for size of metaball (size/distance = brightness)
  float distance = size / sqrt(pow((position.x - location_Ball_One.x)*aspectRatio, 2) + pow(position.y - location_Ball_One.y, 2));
  pixelColor += vec4(color_Ball_One.x, color_Ball_One.y, color_Ball_One.z, 1.0) * distance;//scale color intensity by distance (not the best way to do this though)
  
  //repeat for each metaball
  distance = size / sqrt(pow((position.x - location_Ball_Two.x)*aspectRatio, 2) + pow(position.y - location_Ball_Two.y, 2));
  pixelColor += vec4(color_Ball_Two.x, color_Ball_Two.y, color_Ball_Two.z, 1.0) * distance;
  
  distance = size / sqrt(pow((position.x - location_Ball_Three.x)*aspectRatio, 2) + pow(position.y - location_Ball_Three.y, 2));
  pixelColor += vec4(color_Ball_Three.x, color_Ball_Three.y, color_Ball_Three.z, 1.0) * distance;
  
  distance = size / sqrt(pow((position.x - location_Ball_Four.x)*aspectRatio, 2) + pow(position.y - location_Ball_Four.y, 2));
  pixelColor += vec4(color_Ball_Four.x, color_Ball_Four.y, color_Ball_Four.z, 1.0) * distance;

  distance = size / sqrt(pow((position.x - location_Ball_Five.x)*aspectRatio, 2) + pow(position.y - location_Ball_Five.y, 2));
  pixelColor += vec4(color_Ball_Five.x, color_Ball_Five.y, color_Ball_Five.z, 1.0) * distance;

  //set thresholds (xyz = rgb)
  if(pixelColor.x < threshold){
      pixelColor.x = 0.0;
  }
  if(pixelColor.y < threshold){
      pixelColor.y = 0.00;
  }
  if(pixelColor.z < threshold){
      pixelColor.z = 0.00;
  }

  gl_FragColor = pixelColor;//pass the pixel out
}