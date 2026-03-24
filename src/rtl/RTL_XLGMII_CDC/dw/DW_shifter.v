module DW_shifter(data_in, data_tc, sh, sh_tc, sh_mode, data_out); 

 
 parameter data_width = 8;
 parameter sh_width = 3;
 parameter inv_mode = 0;
 
 input  [data_width-1:0] data_in;
 input  [sh_width-1:0] sh;
 input data_tc, sh_tc, sh_mode; 
 
 output [data_width-1:0] data_out;
  
 wire [sh_width-1:0] sh_int;
 wire data_tc_int, sh_tc_int;
 wire padded_value; 

      
function[data_width-1:0] DWF_shifter_uns_uns;
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  reg   [data_width-1:0] data_out;
  integer j;

  begin 
    if(sh_mode == 1'b1)
      begin
         DWF_shifter_uns_uns = data_in << sh;
      end
    else begin
         data_out = data_in << (sh % data_width);
         for ( j = 0; j < (sh % data_width) ; j = j+1 )
              data_out[j] = data_in[ data_width - (sh % data_width) + j ];
         DWF_shifter_uns_uns = data_out;
    end
  end
endfunction


function[data_width-1:0] DWF_shifter_tc_uns;
 
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  reg   [data_width-1:0] data_out;
  integer j;
 
  begin
    if(sh_mode == 1'b1)
      begin
         DWF_shifter_tc_uns = data_in << sh;
      end
    else begin
         data_out = data_in << (sh % data_width);
         for ( j = 0; j < (sh % data_width) ; j = j+1 )
              data_out[j] = data_in[ data_width - (sh % data_width) + j ];
         DWF_shifter_tc_uns = data_out;
    end
  end
endfunction


function[data_width-1:0] DWF_shifter_uns_tc;
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  reg   [data_width-1:0] data_out;
  reg [sh_width-1:0] sh_abs;
  integer j;
 
  begin
    if(sh_mode == 1'b1)
       begin
         if(sh[sh_width-1] == 1'b0) 
           DWF_shifter_uns_tc = data_in << sh;
         else
           DWF_shifter_uns_tc = data_in >> (-sh);
       end
    else begin
         if(sh[sh_width-1] == 1'b0) begin
           data_out = data_in << (sh % data_width);
           for ( j = 0; j < (sh % data_width) ; j = j+1 )
                data_out[j] = data_in[ data_width - (sh % data_width) + j ];
           DWF_shifter_uns_tc = data_out;
         end
         else begin
           sh_abs = -sh;
           data_out = data_in >> (-sh);
           for ( j = (data_width - (sh_abs )); j <= (data_width-1) ; j = j+1 )
              begin
                data_out[j] = data_in[ (j + (sh_abs )) % data_width ];
              end
           DWF_shifter_uns_tc = data_out;
         end
    end
  end
endfunction


function[data_width-1:0] DWF_shifter_tc_tc;
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  integer j;
  reg [data_width-1:0] data_out;
  reg [sh_width-1:0] sh_abs;
  reg data_sign;
 
  begin
    if(sh_mode == 1'b1)
      begin
         if (sh[sh_width-1] == 1'b0) begin
           data_sign = data_in[data_width-1];
           DWF_shifter_tc_tc = data_in << sh;
         end
         else begin
           sh_abs = -sh;
           data_sign = data_in[data_width-1];
           data_out = data_in >> sh_abs;
           // sign extension of right shifted data
           for(j=0; j<data_width; j=j+1) begin
             if((j > data_width-sh_abs-1)||(sh_abs >= data_width))
                DWF_shifter_tc_tc[j] = data_sign;
              else
                DWF_shifter_tc_tc[j] = data_out[j];
           end
         end
      end
      else begin
         if(sh[sh_width-1] == 1'b0) begin
           data_sign = data_in[data_width-1];
           data_out = data_in << (sh % data_width);
           for ( j = 0; j < (sh % data_width) ; j = j+1 )
                data_out[j] = data_in[ data_width - (sh % data_width) + j ];
           DWF_shifter_tc_tc = data_out;
         end
         else begin
           data_sign = data_in[data_width-1];
           data_out = data_in >> (-sh);
           sh_abs = (-sh);
           for ( j = (data_width - (sh_abs )); j <= (data_width-1) ; j = j+1 )
                data_out[j] = data_in[ (j + (sh_abs )) % data_width ];
           DWF_shifter_tc_tc = data_out;
         end
      end
  end
endfunction


function[data_width-1:0] shift_uns_uns;
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  input padded_value;
   
  reg   [data_width-1:0] data_out;
  reg   [((2*data_width)-1):0] data_out_temp;
  integer j;

  begin 
// so I think the thing to do here is put in a generate statement
// if sh_width is > IW_logb2(data_width-1)+1;
// can I define data_temp to be twice the width of data_in
//
// then do things based on data_width index
// otherwise, do things on sh_width
    if (sh_mode == 1'b1) begin
         // check to make sure shift is less then width of data
         // if (sh < data_width) begin
           data_out_temp = {(2*data_width){1'b0}};
           data_out_temp = data_in << sh;
           for (j = 0; j < sh ; j = j+1)
                data_out_temp[j] = padded_value;
           data_out = data_out_temp[data_width-1:0];
         //end
         //else begin
         //  data_out = {data_width{padded_value}};
         //end
    end
    else begin
         data_out_temp = {(2*data_width){1'b0}};
         data_out = data_in << (sh % data_width);
         for ( j = 0; j < (sh % data_width) ; j = j+1 )
              data_out[j] = data_in[ data_width - (sh % data_width) + j ];
    end
         shift_uns_uns = data_out;
  end
endfunction


function[data_width-1:0] shift_tc_uns;
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  input padded_value;
   
  reg   [data_width-1:0] data_out;
  reg   [((2*data_width)-1):0] data_out_temp;
  reg [sh_width-1:0] sh_abs;
  integer j;

  begin 
    if(sh_mode == 1'b1)
       begin
         if(sh[sh_width-1] == 1'b0) begin
           sh_abs = -sh;
           data_out_temp = {(2*data_width){1'b0}};
           data_out_temp = data_in << sh;
           for ( j = 0; j < sh ; j = j+1 )
                data_out_temp[j] = padded_value;
           data_out = data_out_temp[data_width-1:0];
            //data_out = data_in << sh;
            //for ( j = 0; j < sh ; j = j+1 )
            //   data_out[j] = padded_value;            
         end
         else begin
           sh_abs = -sh;
           data_out_temp = {(2*data_width){1'b0}};
           // data_out_temp = {(2*data_width){1'b0}};
           // data_out_temp = data_in >> sh_abs;
           // for (j = 0; j < sh_abs ; j = j+1)
           //      data_out_temp[data_width-1-j] = padded_value;
           // data_out = data_out_temp[data_width-1:0];

           data_out_temp[((2*data_width)-1):data_width] = data_in >> sh_abs;
           for (j = 0; j < sh_abs ; j = j+1)
                // Start at MSb and pad to the right
                data_out_temp[((2*data_width)-1)-j] = padded_value;
           // assign the output to be the upper half of the data
           data_out = data_out_temp[((2*data_width)-1):data_width];
           //data_out = data_in >> sh_abs;
           // for ( j = 0; j < sh_abs ; j = j+1 )
           //    data_out[data_width-1-j] = padded_value; 
         end
       end
    else begin
       if(sh[sh_width-1] == 1'b0) begin
          sh_abs = -sh;
          data_out_temp = {(2*data_width){1'b0}};
          data_out = data_in << (sh % data_width);
          for ( j = 0; j < (sh % data_width) ; j = j+1 )
             data_out[j] = data_in[ data_width - (sh % data_width) + j ];
       end
       else begin
          data_out_temp = {(2*data_width){1'b0}};
          sh_abs = -sh;
          //data_out = data_in >> sh_abs;
          //for ( j = 0; j < sh_abs ; j = j+1 )
          //   data_out[data_width-1-j] = data_in[sh_abs -1- j ];


           data_out_temp = {(2*data_width){1'b0}};
           data_out_temp[((2*data_width)-1):data_width] = data_in >> sh_abs;
           for (j = 0; j < sh_abs ; j = j+1)
                // Start at MSb and pad to the right
                data_out_temp[((2*data_width)-1)-j] = data_in[sh_abs -1- j ];
           // assign the output to be the upper half of the data
           data_out = data_out_temp[((2*data_width)-1):data_width];
       end           
    end
         shift_tc_uns = data_out;
  end
endfunction


function[data_width-1:0] shift_uns_tc;
 
  input [data_width-1:0] data_in;
  input [sh_width-1:0] sh;
  input sh_mode;
  input padded_value;
   
  reg   [data_width-1:0] data_out;
  reg   [((2*data_width)-1):0] data_out_temp;
  integer j;

  begin 
    if (sh_mode == 1'b1) begin
       data_out_temp = {(2*data_width){1'b0}};
       data_out_temp = data_in << sh;
       for (j = 0; j < sh ; j = j+1 )
          data_out_temp[j] = padded_value;
           
       data_out = data_out_temp[data_width-1:0];
       //data_out = data_in << sh;
       //for ( j = 0; j < sh ; j = j+1 )
       //   data_out[j] = padded_value;
    end
    else begin
       data_out_temp = {(2*data_width){1'b0}};
       data_out = data_in << (sh % data_width);
       for ( j = 0; j < (sh % data_width) ; j = j+1 )
          data_out[j] = data_in[ data_width - (sh % data_width) + j ];
    end
     shift_uns_tc = data_out;
  end
endfunction


function[data_width-1:0] shift_tc_tc;
   
   input [data_width-1:0] data_in;
   input [sh_width-1:0]   sh;
   input                   sh_mode;
   input                   padded_value;
   
   reg       [data_width-1:0] data_out;  
   reg [((2*data_width)-1):0] data_out_temp;
   reg         [sh_width-1:0] sh_abs;
   reg                        data_sign;
   integer                    j;

   begin 
      if(sh_mode == 1'b1)
         begin
            if(sh[sh_width-1] == 1'b0) begin
               data_sign = data_in[data_width-1];
               sh_abs = -sh;
               //data_out = data_in << sh;
               //for ( j = 0; j < sh ; j = j+1 )
               //   data_out[j] = padded_value;            
               data_out_temp = {(2*data_width){1'b0}};
               data_out_temp = data_in << sh;
               for ( j = 0; j < sh ; j = j+1 )
                    data_out_temp[j] = padded_value;
               data_out = data_out_temp[data_width-1:0];
            end
            else begin
               sh_abs = -sh;
               data_sign = data_in[data_width-1];
               //data_out = data_in >> sh_abs;
               //for ( j = 0; j < sh_abs ; j = j+1 )
               //   data_out[data_width-1-j] = data_sign; 
               data_out_temp = {(2*data_width){1'b0}};
               data_out_temp[((2*data_width)-1):data_width] = data_in >> sh_abs;
               for (j = 0; j < sh_abs ; j = j+1)
                    // Start at MSb and pad to the right
                    data_out_temp[((2*data_width)-1)-j] = data_sign;
               // assign the output to be the upper half of the data
               data_out = data_out_temp[((2*data_width)-1):data_width];
            end
         end
      else begin
         if(sh[sh_width-1] == 1'b0) begin
            data_sign = data_in[data_width-1];
            sh_abs = -sh;
            data_out_temp = {(2*data_width){1'b0}};
            data_out = data_in << (sh % data_width);
            for ( j = 0; j < (sh % data_width) ; j = j+1 )
               data_out[j] = data_in[ data_width - (sh % data_width) + j ];
         end
         else begin
            data_sign = data_in[data_width-1];
            sh_abs = -sh;
            //data_out = data_in >> sh_abs;
            //for ( j = 0; j < sh_abs ; j = j+1 )
            //   data_out[data_width-1-j] = data_in[sh_abs -1- j ];
            data_out_temp = {(2*data_width){1'b0}};
            data_out_temp[((2*data_width)-1):data_width] = data_in >> sh_abs;
            for (j = 0; j < sh_abs ; j = j+1)
               // Start at MSb and pad to the right
               data_out_temp[((2*data_width)-1)-j] = data_in[sh_abs -1- j ];
            // assign the output to be the upper half of the data
            data_out = data_out_temp[((2*data_width)-1):data_width];
         end           
      end
      shift_tc_tc = data_out;
   end
endfunction


   assign padded_value =  (inv_mode == 0 || inv_mode == 2) ? 1'b0 : 1'b1;
   assign data_tc_int = (inv_mode == 0 || inv_mode == 1) ? data_tc : ~data_tc;
   assign sh_tc_int = (inv_mode == 0 || inv_mode == 1) ? sh_tc : ~sh_tc;
   assign sh_int = (inv_mode == 0 || inv_mode == 1) ? sh : ~sh;
   
   assign data_out = ((sh_tc_int == 1'b0) & (data_tc_int == 1'b0)) ?
                          shift_uns_uns(data_in, sh_int, sh_mode, padded_value) :
                     ((sh_tc_int == 1'b0) & (data_tc_int == 1'b1)) ?
                          shift_uns_tc(data_in, sh_int, sh_mode, padded_value) :             
                     ((sh_tc_int == 1'b1) & (data_tc_int == 1'b0)) ?
                          shift_tc_uns(data_in, sh_int, sh_mode, padded_value) :
                          shift_tc_tc(data_in, sh_int, sh_mode,padded_value);
 
endmodule  
