<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
	<div style="width: 100%; margin-bottom: 10px;">
		<table style="width: 100%; border-collapse: collapse;">
			<tbody>
			<tr>
				<td style="text-align: center; width: 340px; vertical-align: top;">
					<a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="thickbox" rel="gallery">
						<img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" style="margin-bottom: 3px;" />
					</a><br />
					<span style="font-size: 11px;"><?php echo $text_enlarge; ?></span>
				</td>
				<td style="padding-left: 15px; width: 645px; vertical-align: top;">
					<table width="100%">
						<tbody>
						<tr>
							<td>
							<h1 style="font-size: 28px; margin-bottom: 15px;"><?php echo $heading_title; ?></h1>
								<?php if ($display_price) { ?>
								<span class="priceItem big"><?php echo $price; ?></span>
								<span class="stockStatusItem big"><?php echo $stock; ?></span>
							<?php } ?>
							</td>
						</tr>
						<tr>
							<td style="padding-bottom: 15px;">
							<?php foreach ($options as $option) { ?>
								<span class="sizeTitle"><?php echo $option['name']; ?>:</span>
				                <?php foreach ($option['option_value'] as $option_value) { ?>
				                    <span class="itemSize"><?php echo $option_value['name']; ?></span>
				                <?php } ?>
							<?php } ?>
							</td>
						</tr>
						<tr>
							<td style="padding-bottom: 15px;">
							<div id="vk_like"></div>
							<script type="text/javascript">
								VK.Widgets.Like("vk_like", {type: "full"});
							</script>
							</td>
						</tr>
						<tr>
							<td>
							<?php if ($display_price) { ?>
							<form action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data" id="product">
								<?php if ($display_price) { ?>
									<?php if ($discounts) { ?>
										<b><?php echo $text_discount; ?></b><br />
										<div style="background: #F7F7F7; border: 1px solid #DDDDDD; padding: 10px; margin-top: 2px; margin-bottom: 15px;">
										<table style="width: 100%;">
							                <tr>
							                    <td style="text-align: right;"><b><?php echo $text_order_quantity; ?></b></td>
							                    <td style="text-align: right;"><b><?php echo $text_price_per_item; ?></b></td>
							                </tr>
							                <?php foreach ($discounts as $discount) { ?>
							                <tr>
							                    <td style="text-align: right;"><?php echo $discount['quantity']; ?></td>
							                    <td style="text-align: right;"><?php echo $discount['price']; ?></td>
							                </tr>
							                <?php } ?>
										</table>
										</div>
									<?php } ?>
								<?php } ?>
								<div class="content">
									<?php echo $text_qty; ?>
									<input type="text" name="quantity" size="3" value="<?php echo $minimum; ?>" />
									<?php foreach ($options as $option) { ?>
										<?php echo $option['name']; ?>:&nbsp;
										<select name="option[<?php echo $option['option_id']; ?>]">
						                    <?php foreach ($option['option_value'] as $option_value) { ?>
						                    <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?>
						                    <?php if ($option_value['price']) { ?>
						                    <?php echo $option_value['prefix']; ?><?php echo $option_value['price']; ?>
						                    <?php } ?>
						                    </option>
						                    <?php } ?>
										</select>
									<?php } ?>
									<a onclick="$('#product').submit();" id="add_to_cart" class="button"><?php echo $button_add_to_cart; ?></a>
									<?php if ($minimum > 1) { ?><br/><small><?php echo $text_minimum; ?></small><?php } ?>
								</div>
								<div>
									<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
									<input type="hidden" name="redirect" value="<?php echo str_replace('&', '&amp;', $redirect); ?>" />                
								</div>
							</form>
							<?php } ?>
							<div id="tab_description" class="tab_page"><?php echo $description; ?></div>
							</td>
						</tr>
						</tbody>
					</table>
				</td>
			</tr>
			</tbody>
		</table>
    </div>
    
  
  <?php if ($tags) { ?>
  <div class="tags"><?php echo $text_tags; ?>
  <?php foreach ($tags as $tag) { ?>
  <a href="<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?></a>, 
  <?php } ?>
  </div>
  <?php } ?>
</div>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').slideUp('slow');
		
	$('#review').load(this.href);
	
	$('#review').slideDown('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

function review() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#review_button').attr('disabled', 'disabled');
			$('#review_title').after('<div class="wait"><img src="catalog/view/theme/default/image/loading_1.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#review_button').attr('disabled', '');
			$('.wait').remove();
		},
		success: function(data) {
			if (data.error) {
				$('#review_title').after('<div class="warning">' + data.error + '</div>');
			}
			
			if (data.success) {
				$('#review_title').after('<div class="success">' + data.success + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
}
//--></script>
<script type="text/javascript"><!--
$.tabs('.tabs a'); 
//--></script>
<?php echo $footer; ?> 