New-PSHtmlChartJS -ChartId 'test' -ChartType 'line' -InputObject @(
    @{Title='1';Value=1}
    @{Title='2';Value=2}
    @{Title='3';Value=3}
    @{Title='4';Value=5}
    @{Title='5';Value=5}
) -ArrayTitleProperty Title -ArrayValueProperty Value