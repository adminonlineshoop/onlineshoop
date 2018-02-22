<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>
    <div class="clearfix">
      <strong class="pull-left"><?php echo $review['author']; ?></strong>
      <span class="pull-right"><?php echo $review['date_added']; ?></span>
    </div>
    <?php for ($i = 1; $i <= 5; $i++) { ?>
    <?php if ($review['rating'] < $i) { ?>
    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
    <?php } else { ?>
    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
    <?php } ?>
    <?php } ?>
    <p><?php echo $review['text']; ?></p>
<?php } ?>
<div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
<p><?php echo $text_no_reviews; ?></p>
<?php } ?>
