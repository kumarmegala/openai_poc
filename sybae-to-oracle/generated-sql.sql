CREATE PROCEDURE acpt_check_trans (
    @sec_id INT,
    @sec_no CHAR(5),
    @check_only BIT,
    @debug_flag BIT
)
AS
DECLARE @err INT;
DECLARE @errorcode INT;
DECLARE @sum_of_buys INT;
DECLARE @sum_of_sells INT;
DECLARE @status INT;
DECLARE @msg_text VARCHAR2(255);
IF @debug_flag = 1 THEN
BEGIN
    SELECT @msg_text := TO_CHAR(SYSDATE, 'YYYYMMDD') || ' acpt_check_trans @sec_id=' ||TO_CHAR(@sec_id) ||
 '@sec_no=' || @sec_no ||
'@check_only=' || TO_CHAR(@check_only);
    DBMS_OUTPUT.PUT_LINE(@msg_text);
END;
END IF;

SELECT @status := 0;
IF @check_only = 1 THEN
BEGIN
    SELECT @sum_of_buys := NVL(SUM(qty), 0)
    FROM trans_pend
    WHERE sec_id = @sec_id
      AND type IN ('B', 'L', 'DEL', 'TRF');

    SELECT @err := @@error, @errorcode