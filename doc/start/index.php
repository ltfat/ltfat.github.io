<?php 
$path_include='../../include/';
include($path_include."header.php");
print_header("Documentation","auditory models, documentation");
?>

<body>

  <div class="container">
    
    <!-- nav header -->
    <div class="masthead">
      <?php topmenu("Documentation"); ?>
    </div>

    <?php
    // ----- J U M P L I S T -------------------------------------------------
    // Data for jump list
    include($path_include."../doc/lookup.php");
    echo'<div class="text-right">';
    echo'<div class="input-prepend">';
    echo'<span class="add-on"><b>Go to function</b></span>';
    // Print jump list
    echo '<form class="span3" action="'.$path_include.'redirect.php" method="post">';
    echo '<select name=fun onchange="this.form.submit()">';
    foreach($globalfunlist as $key => $element)
    {   
       if ($name==$key)
       {
          echo '<option value="'.$element.'.php" selected=selected>'.$key.'</option>';
       }
       else
       {
          echo '<option value="'.$element.'.php">'.$key.'</option>';
       }
    }
    echo '</select></form>';
    echo'</div>'; // </input-prepend>
    echo'</div>'; // </text-right>
    ?>

    <div class="row-fluid">

      <div class="span2-doc">
        <?php docnav('') ;?>
      </div><!--</span2>-->

      <div class="span10-doc">

        <h1>Online documentation <?php if(isset($toolboxversion)) echo 'for LTFAT '.$toolboxversion; ?></h1>
        <p>On this site you will find an auto-generated documentation of all functions and models included in the Toolbox
        from the help included in the M-files. This is the most complete, and up-to-date description of the toolbox .</p>
        <p>Please access it using the menu on the left as the starting point.</p>
        <p>The M-file documentation is also available as a  <a href="../ltfat.pdf">pdf file.</a></p>
        <p>Or you may have a look in to the <a href="<?php baseurl(); ?>/notes">Notes</a> section where you will find different PDF about functionality in the toolbox.</p>
		<p>Central documentation for the block-processing framework can be found  <a href="<?php baseurl(); ?>/doc/blockproc_central.php">here</a>.</p>
      </div><!--</span8>-->

      <div class="span2">
      </div><!--</span2>-->

    </div><!--</row-fluid>-->

    <!-- footer -->
    <?php include($path_include."footer.php"); ?>

  </div><!--</container>-->

</div>
</body>
</html>
<!-- vim: set textwidth=120 ts=2 sw=2: -->
