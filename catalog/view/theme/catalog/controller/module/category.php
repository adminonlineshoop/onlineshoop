<?php  
class ControllerModuleCategory extends Controller {
	protected $category_id = 0;
	protected $path = array();
	
	protected function index() {
		$this->language->load('module/category');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->load->model('catalog/category');
		$this->load->model('tool/seo_url');
		
		if (isset($this->request->get['path'])) {
			$this->path = explode('_', $this->request->get['path']);
			
			$this->category_id = end($this->path);
		}
		
		$this->data['category'] = $this->getCategories(0);
												
		$this->id = 'category';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category.tpl';
		} else {
			$this->template = 'default/template/module/category.tpl';
		}
		
		$this->render();
  	}
	
	protected function getCategories($parent_id, $current_path = '') {
		$category_id = array_shift($this->path);
		
		$output = '';
		
		$results = $this->model_catalog_category->getCategories($parent_id);
		
		if ($results) { 
			$output .= '<ul>';
    	}
			
		$children = '';
		
		foreach ($results as $result) {	
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}
			
			$output .= '';
			
			if ($category_id == $result['category_id']) {
				$children = $this->getCategories($result['category_id'], $new_path);
			}
			
			if ($this->category_id == $result['category_id']) {
				$output .= '<li class="current_page_item current-menu-item">';
				$output .= '<a href="' . $this->model_tool_seo_url->rewrite(HTTP_SERVER . 'index.php?route=product/category&amp;path=' . $new_path)  . '">' . $result['name'] . '</a>';
			} else {
				$output .= '<li>';
				$output .= '<a href="' . $this->model_tool_seo_url->rewrite(HTTP_SERVER . 'index.php?route=product/category&amp;path=' . $new_path)  . '">' . $result['name'] . '</a>';
			}
        
        	$output .= '</li>'; 
		}
 
		if ($results) {
			$output .= '</ul>';
		}
		
		if($children) {
			$output .= '</div><div id="subCategory" class="category"><table align="center"><tbody><tr><td>' . $children . '</td></tr></tbody></table>';
		}
		
		return $output;
	}		
}
?>