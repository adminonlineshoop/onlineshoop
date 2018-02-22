<?php if ($products) { ?>
<table class="list" border="0" cellpadding="0" cellspacing="0">
    <?php for ($i = 0; $i < sizeof($products); $i = $i + 4) { ?>
    <tr>
        <?php for ($j = $i; $j < ($i + 4); $j++) { ?>
        <td width="235"><?php if (isset($products[$j])) { ?>
          <span class="itemCategory"><?php echo $products[$j]['catname']; ?></span>/
          <a href="<?php echo $products[$j]['href']; ?>"><img src="<?php echo $products[$j]['thumb']; ?>" title="<?php echo $products[$j]['name']; ?>" alt="<?php echo $products[$j]['name']; ?>" /></a><br />
          <a class="categoryItem" href="<?php echo $products[$j]['href']; ?>"><?php echo $products[$j]['name']; ?></a><br />
          <span class="priceItem"><?php echo $products[$j]['price']; ?></span>
          <span class="stockStatusItem<?php if ($products[$j]['stock_status_id'] == 7) { ?> in<?php } ?>"><?php echo $products[$j]['stock_status']; ?></span>
          <a class="button_add_small" href="<?php echo $products[$j]['add']; ?>" title="<?php echo $button_add_to_cart; ?>" >&nbsp;</a>
          <br />
          <?php if ($products[$j]['rating']) { ?>
          <img src="catalog/view/theme/default/image/stars_<?php echo $products[$j]['rating'] . '.png'; ?>" alt="<?php echo $products[$j]['stars']; ?>" />
          <?php } ?>
          <?php } ?></td>
		  <?php if ($j != $i + 3) { ?><td width="20">&nbsp;</td><?php } ?>
        <?php } ?>
    </tr>
    <?php } ?>
</table>
<?php } ?>