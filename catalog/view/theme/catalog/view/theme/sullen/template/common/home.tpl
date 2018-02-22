	<?php echo $header; ?>
	<?php echo $column_left; ?>
</div>
<div id="content">
  <?php foreach ($modules as $module) { ?>
  <?php echo ${$module['code']}; ?>
  <?php } ?>
</div>
<?php echo $footer; ?> 