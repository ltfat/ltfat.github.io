function author(initials,name,link,description){
    this.initials = initials;
    this.name = name;
    this.firstname = name.split(' ')[0];
    this.link = link;
    this.description = description;
}

function authorToHTML(author){
  var retstr = "<div class=\"col-md-3\">\n";
  retstr += "<div class=\"thumbnail\">\n";
  //retstr += '<a href="'+author.link+'">';
  retstr += "<img src=\"images/"+author.initials+".jpg\" alt=\"\" width=\"200\">\n";//</a>\n";
  retstr += "<div class=\"caption\"><h3>"+author.name+"</h3>\n";
  retstr += "<p>"+author.description+"</p>\n";
  retstr += "</div></div></div>\n";
  return retstr;
}

var authors =
[
  new author("ch","Clara Hollomey",
  "https://www.oeaw.ac.at/en/ari/our-team/hollomey-clara",
  "Current maintainer of the toolbox."),
new author("zp","Zdeněk Průša","http://www.kfs.oeaw.ac.at/index.php?option=com_content&view=article&id=662:prusa-zdenek-ing&catid=13&Itemid=419&lang=en",
           "Maintainer of the toolbox from 2013 to 2018. Has implemented the wavelets, the block-processing routines and revised the C backend."),
new author("ps","Peter L. Søndergaard",
           "http://www.kfs.oeaw.ac.at/index.php?option=com_content&view=article&id=664:soendergaard-peter-l-dr&catid=13&Itemid=419&lang=en",
           "Original founder of the toolbox. Wrote most of the Gabor routines and the original C backend."),
new author("nh","Nicki Holighaus","http://www.kfs.oeaw.ac.at/index.php?option=com_content&view=article&id=660:holighaus-di-nicki&catid=13&Itemid=419&lang=en",
           "Worked on non-stationary and non-separable Gabor systems, CQT, ERBlets, warped filterbanks and filterbank reassignment."),
new author("np","Nathanaël Perraudin","http://people.epfl.ch/nathanael.perraudin",
           "Worked on the <a href='http://mat2doc.sourceforge.net'>mat2doc</a> documentation system and the webpage."),
new author("pb","Peter Balazs","http://www.kfs.oeaw.ac.at/index.php?option=com_content&view=article&id=51:dr-peter-balazs&catid=42&Itemid=634&lang=en",
           "One of the original founders and has worked on demos and frames."),
new author("bt","Bruno Torrésani","http://www.cmi.univ-mrs.fr/~torresan/",
           "One of the original founders and has worked on demos, thresholding and lasso routines."),
new author("md","Monika Döerfler","http://homepage.univie.ac.at/monika.doerfler",
           "Worked on spreading functions and best approximation of Gabor multipliers."),
new author("fj","Florent Jaillet","http://www.kfs.oeaw.ac.at/index.php?option=com_content&view=article&id=389:dr-florent-jaillet&catid=29&Itemid=420&lang=en",
           "Created the original implementation of the non-stationary Gabor frames."),
new author("cw","Christoph Wiesmeyr","http://homepage.univie.ac.at/christoph.wiesmeyr",
           "Wrote the algorithms for the non-separable Gabor lattices and the fractional Fourier transforms."),
new author("jv","Jordy van Velthoven","mailto:jt.vanvelthoven@gmail.com",
           "Wrote several LTFAT notes worked on quadratic time-frequency distributions, documentation and examples."),
];

// Write the authors to the page directly
for(aIdx in authors){
    document.write(authorToHTML(authors[aIdx]));
}
