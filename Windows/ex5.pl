s --> np,vp.
np --> pn.
np --> d,n,rel. % ������������, ���������������, ���������
vp --> tv,np. % ������������ ������ � ���������������
vp --> iv.  % �������������� ������
rel --> [].
rel --> rpn,vp. % ������������� ���������� � ���������� �����
pn --> [PN],{pn(PN)}.
pn(mary).
pn(herry).
rpn --> [RPN],{rpn(RPN)}.
rpn(that).
rpn(which).
rpn(who).
iv --> [IV],{iv(IV)}.
iv(runs).
iv(sits).
d --> [DET],{d(DET)}.
d(a).
d(the).
n --> [N],{n(N)}.
n(book).
n(girl).
n(boy).
tv --> [TV],{tv(TV)}.
tv(gives).
tv(reads).