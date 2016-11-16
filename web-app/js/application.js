if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}


var table;

$(document).ready(function () {


	var config = {
	'.chosen-select'           : {},
	'.chosen-select-deselect'  : {allow_single_deselect:true},
	'.chosen-select-no-single' : {disable_search_threshold:10},
	'.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
	'.chosen-select-width'     : {width:"95%"}
	}
	for (var selector in config) {
		$(selector).chosen(config[selector]);
	}


	/* dataTablesList */
	$('.dataTablesList tfoot th').each( function () {
        var title = $('.dataTablesList thead th').eq( $(this).index() ).text();
        console.log($(this).index())
        if($(this).index() !=0 ){
        	$(this).html( '<input type="text" placeholder="Search '+title+'" />' );	
        }
        
    });
 
    // DataTable
    table = $('.dataTablesList').DataTable({
    	"paging": true,
	     "lengthChange": false,
	     "searching": true,
	     "ordering": true,
	     "info": true,
	     "autoWidth": true,
	     "scrollX": true
    });
 
    // Apply the search
    table = table.columns().eq( 0 );
    if(table){
    table.columns().eq( 0 ).each( function ( colIdx ) {
    	
    	
    		$( 'input', table.column( colIdx ).footer() ).on( 'keyup change', function () {
            table
                .column( colIdx )
                .search( this.value )
                .draw();
        	} );
    	
    });
    }

/*    $('#chat-box').slimScroll({
        height: '150px'
    });*/

});

function formatNumber(val,row){
	if (val==null){val=0.0}
    if (val < 0){
        return '<span style="color:red;">('+numeral(val).format('0,0.00')+')</span>';
    } else {
        return numeral(val).format('0,0.00');
    }
}

if ($('#back-to-top').length) {
    var scrollTrigger = 100, // px
        backToTop = function () {
            var scrollTop = $(window).scrollTop();
            if (scrollTop > scrollTrigger) {
                $('#back-to-top').addClass('show');
            } else {
                $('#back-to-top').removeClass('show');
            }
        };
    backToTop();
    $(window).on('scroll', function () {
        backToTop();
    });
    $('#back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html,body').animate({
            scrollTop: 0
        }, 700);
    });
}

(function($) {

$(document)
    .on( 'hidden.bs.modal', '.modal', function() {
        $(document.body).removeClass( 'modal-scrollbar' );
    })
    .on( 'show.bs.modal', '.modal', function() {
        // Bootstrap's .modal-open class hides any scrollbar on the body,
        // so if there IS a scrollbar on the body at modal open time, then
        // add a right margin to take its place.
        if ( $(window).height() < $(document).height() ) {
            $(document.body).addClass( 'modal-scrollbar' );
        }
    });

})(window.jQuery);


var randomColor = function() {
    return '#'+Math.floor(Math.random()*16777215).toString(16);
};    

//-------------
//- BAR CHART -
//-------------

var barChartOptions = {
  //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
  scaleBeginAtZero: true,
  //Boolean - Whether grid lines are shown across the chart
  scaleShowGridLines: true,
  //String - Colour of the grid lines
  scaleGridLineColor: "rgba(0,0,0,.05)",
  //Number - Width of the grid lines
  scaleGridLineWidth: 1,
  //Boolean - Whether to show horizontal lines (except X axis)
  scaleShowHorizontalLines: true,
  //Boolean - Whether to show vertical lines (except Y axis)
  scaleShowVerticalLines: true,
  //Boolean - If there is a stroke on each bar
  barShowStroke: true,
  //Number - Pixel width of the bar stroke
  barStrokeWidth: 2,
  //Number - Spacing between each of the X value sets
  barValueSpacing: 5,
  //Number - Spacing between data sets within X values
  barDatasetSpacing: 1,
  //String - A legend template
  
  //Boolean - whether to make the chart responsive
  responsive: true,
  maintainAspectRatio: true,

};

