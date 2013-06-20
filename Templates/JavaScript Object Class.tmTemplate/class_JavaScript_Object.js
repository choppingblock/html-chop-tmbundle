/**
 * Creates a new ${TM_NEW_FILE_BASENAME} object.
 *
 * @author ${TM_FULLNAME}
 * @version 0.1
 * @created ${TM_DATE} ${TM_ORGANIZATION_NAME}
 * @copyright (c) ${TM_YEAR} ${TM_ORGANIZATION_NAME}. All rights reserved.
 * 
 * @constructor
 */

function ${TM_NEW_FILE_BASENAME}( color, posx, posy, scale ) {
	/** @lends MyClass# */
	
	//--------------------------------------------------------------------------
	//
 	//  Variables, Constants & Bindings
	//
	//--------------------------------------------------------------------------
	
    this.color = color;
	
	// the position of the particle
	this.posX = posx;
	this.posY = posy;
	
	// the velocity 
	// this.velX = 0; 
	// this.velY = 0;
	
	this.scale = scale;

	// multiply the velocity by this every frame to create
	// drag. A number between 0 and 1, closer to one is 
	// more slippery, closer to 0 is more sticky. values
	// below 0.6 are pretty much stuck :) 
	// this.drag = 1; 
	
	// add this to the yVel every frame to simulate gravity
	// this.gravity = 0;

	//--------------------------------------------------------------------------
    //
    //  Init Methods
    //
    //--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
    //
    //  Create / Destroy Methods
    //
    //--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

	/**
	 * Updates any calculations or properties required for draw.
	 * @param {Object} canvas where this object exists.
	 * @returns Null
	 */
	
	this.update = function(canvas) {
	
		// simulate drag
		// this.velX *= this.drag; 
		// this.velY *= this.drag;
		
		// add gravity force to the y velocity 
		// this.velY += this.gravity; 
		
		// and the velocity to the position
		// this.posX += this.velX;
		// this.posY += this.velY;
		
	}
	
	/**
	 * Draws the object to the approperate context.
	 * @param {Object} ctx where this object should draw.
	 * @returns Null
	 */
	
	this.render = function(ctx) {
	
		// save the current canvas state
		ctx.save(); 
		
		// move to where the particle should be
		ctx.translate(this.posX, this.posY);
	
		// move the draw position to the center of the image
		ctx.translate(0, 0);
		ctx.scale(this.scale, this.scale);
		
		// draw it
		ctx.strokeStyle = this.color;
		ctx.moveTo(-10, 0);
		ctx.lineTo(10, 0);
		ctx.moveTo(0, -10);
		ctx.lineTo(0, 10);
		ctx.stroke();
		
		// and restore the canvas state
		ctx.restore();
	
	}
	
	// returns a random number between the two limits provided 
	function randomRange(min, max)
	{
		return ((Math.random()*(max-min)) + min); 
	}
	
	//--------------------------------------------------------------------------
    //
    //  Event Handlers
    //
    //--------------------------------------------------------------------------
	
}