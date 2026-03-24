module  skid_buf  #(
  parameter WIDTH = 1

) (

   input  logic             clk
  ,input  logic             rst_n

  ,input  logic             valid_i
  ,output logic             ready_i
  ,output logic             wait_i
  ,input  logic [WIDTH-1:0] data_i

  ,output logic             valid_o
  ,output logic             valid_next_o
  ,input  logic             ready_o
  ,output logic [WIDTH-1:0] data_o

);

  logic [WIDTH-1:0]         skid_data;
  logic                     skid_valid;

  logic                     skid_overflow;

  logic [WIDTH-1:0]         data_next_o;

  always@(posedge clk,  negedge rst_n)
  begin
    if(~rst_n)
    begin
      valid_o                 <=  1'b0;
      data_o                  <=  {WIDTH{1'b0}};

      ready_i                 <=  1'b1;
      wait_i                  <=  1'b0;

      skid_data               <=  {WIDTH{1'b0}};
      skid_valid              <=  1'b0;

      skid_overflow           <=  1'b0;
    end
    else
    begin
      skid_overflow           <=  skid_overflow | (valid_i & ~ready_i & skid_valid);

      if(wait_i)
      begin
        ready_i               <=  ready_o;
        wait_i                <=  ~ready_o;
      end
      else
      begin
        ready_i               <=  valid_i ? ready_o   : ready_i;
        wait_i                <=  valid_i ? ~ready_o  : wait_i;
      end

      if(skid_valid)
      begin
        skid_valid            <=  ~ready_o;
        skid_data             <=  ready_o ? data_i  : skid_data;
      end
      else
      begin
        skid_valid            <=  valid_i & ~ready_i & ~ready_o;
        skid_data             <=  data_i;
      end

      valid_o                 <=  valid_next_o;
      data_o                  <=  data_next_o;
    end
  end

  always_comb
  begin
    valid_next_o  = valid_o;
    data_next_o   = data_o;

    if(valid_o)
    begin
      if(ready_o)
      begin
        if(skid_valid)
        begin
          valid_next_o      =  1'b1;
          data_next_o       =  skid_data;
        end
        else
        begin
          valid_next_o      =  valid_i;
          data_next_o       =  data_i;
        end
      end
    end
    else  //~valid_o
    begin
      if(skid_valid)
      begin
        valid_next_o        =  1'b1;
        data_next_o         =  skid_data;
      end
      else
      begin
        valid_next_o        =  valid_i;
        data_next_o         =  data_i;
      end
    end
  end

endmodule //skid_buf
