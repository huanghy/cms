<?xml version="1.0" ?><ParticleEffect maxParticles="10" name="onfire_particles_03" timeToEmit="-1"><Dampening max="0.65" min="0.4"/><DirectionalForce x="0" y="-1000"><Curves><X multiplier="1"><MinCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MinCurve><MaxCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MaxCurve></X><Y multiplier="1"><MinCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MinCurve><MaxCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MaxCurve></Y><Z multiplier="1"><MinCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MinCurve><MaxCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MaxCurve></Z></Curves></DirectionalForce><Emitter angle="0" emissionRate="0.003" spread="360"><SpawnArea depth="0" height="30" width="2"/></Emitter><Rotation max="360" min="0"/><RotationSpeed max="60" min="50"><Curves multiplier="1"><MinCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MinCurve><MaxCurve><ControlPoint time="-0.01"/><ControlPoint time="1.01"/></MaxCurve></Curves></RotationSpeed><Size><Max x="30" y="30"/><Min x="60" y="60"/></Size><SizeChange type="Curve" x="32" y="32"><Max x="-20" y="-20"/><Min x="-20" y="-20"/><Curves><X multiplier="1"><MinCurve><ControlPoint inSlope="0" outSlope="0" time="-0.01" value="1"/><ControlPoint inSlope="0" outSlope="0" time="0" value="1"/><ControlPoint inSlope="-3.538656473" outSlope="-3.538656473" time="1" value="0.000845958"/><ControlPoint inSlope="0" outSlope="0" time="1.00999999" value="0.000845958"/></MinCurve><MaxCurve><ControlPoint time="-0.01" value="1"/><ControlPoint time="1.01" value="1"/></MaxCurve></X><Y multiplier="1"><MinCurve><ControlPoint inSlope="0" outSlope="0" time="-0.01" value="1"/><ControlPoint inSlope="0" outSlope="0" time="0" value="1"/><ControlPoint inSlope="-2.977534533" outSlope="-2.977534533" time="1" value="-0.018006004"/><ControlPoint inSlope="0" outSlope="0" time="1.00999999" value="-0.018006004"/></MinCurve><MaxCurve><ControlPoint time="-0.01" value="1"/><ControlPoint time="1.01" value="1"/></MaxCurve></Y></Curves></SizeChange><Texture filename="tex/particles/particle_2glows.png" numFramesX="1" numFramesY="1"/><TextureFrame frameInterval="0" numTextureAnimationFrames="1" startFrame="0" textureAnimationSpeed="1"/><TimeToLive max="0.5" min="0.001"/><Velocity max="200" min="0"/><ColorAnimation><Keyframe lifeTime="0"><Color a="0" b="255" g="183" r="0"/></Keyframe><Keyframe lifeTime="0.260377347"><Color a="255" b="255" g="255" r="0"/></Keyframe><Keyframe lifeTime="0.935849071"><Color 