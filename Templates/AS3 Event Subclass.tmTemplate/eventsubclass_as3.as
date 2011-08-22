package {

	import flash.events.Event;

	/**
	 *  Creates an event subclass for
	 *
	 *  <p>usage:
	 *  
	 *  dispatchEvent( new ${TM_NEW_FILE_BASENAME}(${TM_NEW_FILE_BASENAME}.DRAG_START) );
	 *  </p>
	 *  
	 *  @langversion ActionScript 3
	 *  @playerversion Flash 9.0.0
	 *
	 *  @author ${TM_FULLNAME}
	 *  @since  ${TM_DATE}
	 *  @version 0.1
	 *  @copyright (c) ${TM_YEAR} ${TM_ORGANIZATION_NAME}. All rights reserved.
	 *
	 */

	public class ${TM_NEW_FILE_BASENAME} extends Event {

		//--------------------------------------------------------------------------
		//
		//  Variables, Constants & Bindings
		//
		//--------------------------------------------------------------------------

		/**
		*	Public static class vars
		*/
		//public static const DRAG_START			:String = "dragStart";

		/**
		*	Public class vars (create as needed)
		*/
		//public var message						:String;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		*	Constructor
		*	@param type The message of the event.
		*/
		public function ${TM_NEW_FILE_BASENAME} (type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//--------------------------------------------------------------------------		
		/**
     	*	Creates and returns a copy of the current instance.
		*	@return A copy of the current instance.
		*/
		override public function clone():Event {
			return new ${TM_NEW_FILE_BASENAME}(type, bubbles, cancelable);
		}
	}
}