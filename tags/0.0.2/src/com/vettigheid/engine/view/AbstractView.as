package com.vettigheid.engine.view
{
	import com.vettigheid.engine.model.ModelLocator;
	
	import mx.core.UIComponent;

	public class AbstractView extends UIComponent
	{
		private var _model:ModelLocator;
		
		public function AbstractView()
		{
			_model = ModelLocator.getInstance();
		}
		
		protected function get model():ModelLocator
		{
			return _model;
		}
	}
}