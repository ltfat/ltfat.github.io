<?php 
$path_include='../../include/';
include($path_include."header.php");
print_header("Notes for The Large Time-Frequency Analysis Toolbox","Gabor, time, frequency, wavelet, preprint, articles");
?>

<body>

  <div class="container">
    
    <!-- nav header -->
    <div class="masthead">
      <?php topmenu("Notes"); ?>
    </div>

    <!-- main page -->
    <div class="row-fluid">

      <div class="span12">
          
        <br/>
        <h1>LTFAT: A Matlab/Octave toolbox for sound
processing</h1>
<div class="row-fluid">
Complementary material (audio samples) accompanying the paper: <br/>

<blockquote>
  <p>Průša, Z., Søndergaard, P.L., Balazs, P., Holighaus, N.: "LTFAT: A Matlab/Octave toolbox for sound
processing," In Proceedings of the 
10th International Symposium on Computer Music Multidisciplinary Research (CMMR), Marseille, France, 2013
</p>
</blockquote>

Click at the appropriate spectrogram to start the playback.

</div>
  
 <div class="row-fluid">
 <div class="span6 pagination-centered">
 <a href="glockenspiel.wav"><img src="glock_maskGray_3.gif" alt="CQT spectrogram of the test signal"></a>
 (a) CQT spectrogram of the test signal
 </div><!--</span>-->
<div class="span6 pagination-centered">
 <img src="glock_maskGray_6.gif" alt="Symbol">
 (b) Symbol
 </div><!--</span>-->
  </div><!--</row-fluid>-->
 <br/>  
  <div class="row-fluid">
<div class="span6 pagination-centered">
 <a href="glockenspiel_msk.wav"><img src="glock_maskGray_4.gif" alt="Original spectrogram"></a>
 (c) Effect of the multiplier.
 </div><!--</span>-->
<div class="span6 pagination-centered">
 <a href="glockenspiel_iso.wav"><img src="glock_maskGray_5.gif" alt="Effect of the multiplier using the inverse
symbol"></a>
(d) Effect of the multiplier using the inverse symbol.
 </div><!--</span>-->
 </div><!--</row-fluid>-->
  <br/>
 Fig.3: Deleting/isolating object in a spectrogram using a frame multiplier. Values of the mask (symbol) on (b) are between 0 (white) and 1 (black). The results
on (c) and (d) are obtained by an analysis of the outcome of the multiplier operator.

  <hr/>

 <div class="row-fluid">
 <div class="span6 pagination-centered">
 <a href="glockenspiel.wav"><img src="glock_excerpt.gif" alt="Detail of the CQT of the test signal"></a>
 (a) Detail of the CQT of the test signal
 </div><!--</span>-->
<div class="span6 pagination-centered">
 <a href="glock-cqt-mask-sep.wav"><img src="glock_mod_excerpt.gif" alt="Detail of the CQT of the result"></a>
 (b) Detail of the CQT of the result
 </div><!--</span>-->
  </div><!--</row-fluid>-->
 <br/>  
  <div class="row-fluid">
<div class="span4 pagination-centered">
 <img src="sine_mask.gif" alt="Harmonic mask">
 (c) Harmonic mask
 </div><!--</span>-->
<div class="span4 pagination-centered">
<img src="trans_mask.gif" alt="Transient mask">
(d) Transient mask
 </div><!--</span>-->
 <div class="span4 pagination-centered">
 <img src="rem_mask.gif" alt="Remainder mask">
(e) Remainder mask
 </div><!--</span>-->
 </div><!--</row-fluid>-->
 
<div class="row-fluid">
<div class="span4 pagination-centered">
 <a href="cqt_sin.wav"><img src="glock_sin.gif" alt="Harmonic part"></a>
 (f) Harmonic part
 </div><!--</span>-->
<div class="span4 pagination-centered">
 <a href="cqt_tr.wav"><img src="glock_trans.gif" alt="Transient part"></a>
(g) Transient part
 </div><!--</span>-->
 <div class="span4 pagination-centered">
  <a href="cqt_rem.wav"><img src="glock_remainder.gif" alt="Remainder"> </a>
(h) Remainder
 </div><!--</span>-->
 </div><!--</row-fluid>-->
 
  <br/>
 Fig.4: Transposition of a single harmonic structure of the test signal glockenspiel.
 <hr/>


 </div><!--</span12>-->
      
      

    </div><!--</row-fluid>-->

    <!-- footer -->
    <?php include($path_include."footer.php"); ?>

  </div><!--</container>-->

</div>
</body>
</html>





