//created by kx144

//get value of piece at (i,j)
int getPiece(ArrayList<int[]> position,int i,int j) {
  int[] row = position.get(j);
  return row[i];
}

//checks if there is a check supposedly
boolean inCheck(int i,int j,int clickedi,int clickedj) {
  ArrayList<int[]> testposition = new ArrayList<int[]>();
  for (int a=0;a<8;a++) {
    testposition.add(position.get(a));
  }
  
  //pseudo move
  setPiece(testposition,getPiece(testposition,clickedi,clickedj),i,j);
  setPiece(testposition,0,clickedi,clickedj);
  
  //find position of king
  int kx = 0;
  int ky = 0;
  
  for (int a=0;a<8;a++) {
    for (int b=0;b<8;b++) {
      if (getPiece(testposition,a,b) == 6*turn) {
        kx = a;
        ky = b;
      }
    }
  }
  
  //tests if king is under attack horizontally or vertically
  for (int a=0;a<8;a++) {
    if (((getPiece(testposition,a,ky) == -4*turn || getPiece(testposition,a,ky) == -5*turn) && checkFree(testposition,a,ky,kx,ky)) || ((getPiece(testposition,kx,a) == -4*turn || getPiece(testposition,kx,a) == -5*turn) && checkFree(testposition,kx,a,kx,ky))) {
      checkedi = kx;
      checkedj = ky;
      return true;
    }
  }
  
  //tests if king is under attack diagonally
  int c=0;
  while (kx+c < 8 && ky-c >= 0) {
    if ((getPiece(testposition,kx+c,ky-c) == -3*turn || getPiece(testposition,kx+c,ky-c) == -5*turn) && checkFree(testposition,kx+c,ky-c,kx,ky)) {
      checkedi = kx;
      checkedj = ky;
      return true;
    }
    c++;
  }
  c=0;
  while (kx-c >= 0 && ky-c >= 0) {
    if ((getPiece(testposition,kx-c,ky-c) == -3*turn || getPiece(testposition,kx-c,ky-c) == -5*turn) && checkFree(testposition,kx-c,ky-c,kx,ky)) {
      checkedi = kx;
      checkedj = ky;
      return true;
    }
    c++;
  }
  c=0;
  while (kx+c < 8 && ky+c < 8) {
    if ((getPiece(testposition,kx+c,ky+c) == -3*turn || getPiece(testposition,kx+c,ky+c) == -5*turn) && checkFree(testposition,kx+c,ky+c,kx,ky)) {
      checkedi = kx;
      checkedj = ky;
      return true;
    }
    c++;
  }
  c=0;
  while (kx-c >= 0 && ky+c < 8) {
    if ((getPiece(testposition,kx-c,ky+c) == -3*turn || getPiece(testposition,kx-c,ky+c) == -5*turn) && checkFree(testposition,kx-c,ky+c,kx,ky)) {
      checkedi = kx;
      checkedj = ky;
      return true;
    }
    c++;
  }
  
  //tests if king is under attack by pawn
  if (ky != (1-turn)*3.5) {
    if (kx != 0 && kx != 7) {
      if (getPiece(testposition,kx-1,ky-turn) == -1*turn || getPiece(testposition,kx+1,ky-turn) == -1*turn) {
        checkedi = kx;
        checkedj = ky;
        return true;
      }
    } else {
      if (getPiece(testposition,kx+1-int(kx/3.5),ky-turn) == -1*turn) {
        checkedi = kx;
        checkedj = ky;
        return true;
      }
    }
  }
  
  //tests if king is under attack by king
  if (kx != 0 && kx != 7 && ky != 0 && ky != 7) {
    for (int a=-1;a<2;a++) {
      for (int b=-1;b<2;b++) {
        if (getPiece(testposition,kx-a,ky-b) == -6*turn) {
          checkedi = kx;
          checkedj = ky;
          return true;
        }
      }
    }
  }
  if ((kx == 0 || kx == 7) && ky != 0 && ky != 7) {
    for (int a=-1;a<1;a++) {
      for (int b=-1;b<2;b++) {
        if (getPiece(testposition,kx+a*(int(kx/3.5)-1),ky-b) == -6*turn) {
          checkedi = kx;
          checkedj = ky;
          return true;
        }
      }
    }
  }
  if ((ky == 0 || ky == 7) && kx != 0 && kx != 7) {
    for (int a=-1;a<2;a++) {
      for (int b=-1;b<1;b++) {
        if (getPiece(testposition,kx-a,ky+b*(int(ky/3.5)-1)) == -6*turn) {
          checkedi = kx;
          checkedj = ky;
          return true;
        }
      }
    }
  }
  if ((kx == ky || kx == 7-ky) && (kx == 0 || kx == 7)) {
    for (int a=-1;a<1;a++) {
      for (int b=-1;b<1;b++) {
        if (getPiece(testposition,kx+a*(int(kx/3.5)-1),ky+b*(int(ky/3.5)-1)) == -6*turn) {
          checkedi = kx;
          checkedj = ky;
          return true;
        }
      }
    }
  }
  
  //tests if king is under attack by knight
  if ((kx > 1 && ky > 0 && getPiece(testposition,kx-2,ky-1) == -2*turn) || (kx > 0 && ky > 1 && getPiece(testposition,kx-1,ky-2) == -2*turn) || (kx < 7 && ky > 1 && getPiece(testposition,kx+1,ky-2) == -2*turn) || (kx < 6 && ky > 0 && getPiece(testposition,kx+2,ky-1) == -2*turn) || (kx < 6 && ky < 7 && getPiece(testposition,kx+2,ky+1) == -2*turn) || (kx < 7 && ky < 6 && getPiece(testposition,kx+1,ky+2) == -2*turn) || (kx > 0 && ky < 6 && getPiece(testposition,kx-1,ky+2) == -2*turn) || (kx > 1 && ky < 7 && getPiece(testposition,kx-2,ky+1) == -2*turn)) {
    checkedi = kx;
    checkedj = ky;
    return true;
  }
  
  return false;
}

void checkPromotion(ArrayList<int[]> position) {
   for (int i=0;i<8;i++) {
     if (getPiece(position,i,0) == 1) {
       promotion = i;
     }
     
     if (getPiece(position,i,7) == -1) {
       promotion = i;
       setPiece(position,5*turn,i,7);
     }
   }
}

void setPiece(ArrayList<int[]> position,int value,int i,int j) {
  int[] row = position.get(j);
  int[] newrow = {};
  
  for (int k=0;k<8;k++) {
    if (k != i) {
      newrow = append(newrow,row[k]);
    } else {
      newrow = append(newrow,value);
    }
  }
  
  position.set(j,newrow);
}

//check if there is a piece between (i,j) and (clickedi,clickedj)
boolean checkFree(ArrayList<int[]> position,int i,int j,int clickedi,int clickedj) {
  //check if piece is rook or queen or pawn
  if (clickedi == i || clickedj == j) {
    if (abs(clickedi - i) > 1) {
      for (int a=1;a<abs(clickedi-i);a++) {
        if (getPiece(position,min(clickedi,i)+a,j) != 0) { //if the piece at the minimum of i and clickedi added on to a is a piece, then obv there is a piece blocking
          return false;
        }
      }
      return true;
    } else {
      for (int a=1;a<abs(clickedj-j);a++) {
        if (getPiece(position,i,min(clickedj,j)+a) != 0) {
          return false;
        }
      }
      return true;
    }
  } else { //then bishop or queen
    if (abs(clickedi-i) > 1) {
      int dir1 = (i-clickedi)/abs(i-clickedi);
      int dir2 = (j-clickedj)/abs(j-clickedj);
      
      for (int a=1;a<abs(clickedi-i);a++) {
        if (getPiece(position,clickedi+a*dir1,clickedj+a*dir2) != 0) {
          return false;
        }
      }
      return true;
    }
  }
  return true;
}

//check if u can move the point from (i,j) to (clickedi,clickedj)
//remember i,j,clickedi,clickedj are from 0 to 7, where 0,0 is top left corner
boolean checkMove(int i,int j,int clickedi,int clickedj) {
  switch (getPiece(position,clickedi,clickedj)) {
    case -6: //bking
      if (((abs(clickedi-i) == 0 && abs(clickedj-j) == 1) || (abs(clickedi-i) == 1 && abs(clickedj-j) == 0) || (abs(clickedi-i) == 1 && abs(clickedj-j) == 1)) && !inCheck(i,j,clickedi,clickedj)) {
        setPiece(position,0,i,j);
        bCastleleft = false;
        bCastleright = false;
        enpassanti = -1;
        enpassantj = -1;
        return true;
      } else {
        if (bCastleleft == true && checkFree(position,i,j,clickedi,clickedj) && i == 2 && j == 0 && !inCheck(i,j,i,j)) {
          setPiece(position,0,0,0);
          setPiece(position,-4,3,0);
          bCastleleft = false;
          bCastleright = false;
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
        if (bCastleright == true && checkFree(position,i,j,clickedi,clickedj) && i == 6 && j == 0 && !inCheck(i,j,i,j)) {
          setPiece(position,0,7,0);
          setPiece(position,-4,5,0);
          bCastleleft = false;
          bCastleright = false;
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
      }
      return false;
    case -5: //bqueen
      if ((abs(clickedi - i) == abs(clickedj - j) || clickedi == i || clickedj == j) && !inCheck(i,j,clickedi,clickedj)) {
        if (checkFree(position,i,j,clickedi,clickedj)) {
          setPiece(position,0,i,j);
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
      }
      return false;
    case -4: //brook
      if (((clickedi == i || clickedj == j) && !inCheck(i,j,clickedi,clickedj)) && checkFree(position,i,j,clickedi,clickedj)) {
        if (clickedi == 0 && clickedj == 0) {
          bCastleleft = false;
        }
        if (clickedi == 7 && clickedj == 0) {
          bCastleright = false;
        }
        
        setPiece(position,0,i,j);
        enpassanti = -1;
        enpassantj = -1;
        return true;
      }
      return false;
    case -3: //bbishop
      if ((abs(clickedi - i) == abs(clickedj - j)) && !inCheck(i,j,clickedi,clickedj)) {
        if (checkFree(position,i,j,clickedi,clickedj)) {
          setPiece(position,0,i,j);
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
      }
      return false;
    case -2: //bknight
      if (((abs(clickedi-i) == 2 && abs(clickedj-j) == 1) || (abs(clickedi-i) == 1 && abs(clickedj-j) == 2)) && !inCheck(i,j,clickedi,clickedj)) {
        setPiece(position,0,i,j);
        enpassanti = -1;
        enpassantj = -1;
        return true;
      }
      return false;
    case -1: //bpawn
      if (enpassanti == clickedi-1 && enpassantj == clickedj && clickedi > 0 && getPiece(position,clickedi-1,clickedj) == 1 && i == clickedi-1 && j == clickedj+1) {
        enpassanti = -1;
        enpassantj = -1;
        setPiece(position,0,clickedi-1,clickedj);
        return true;
      }
      if (enpassanti == clickedi+1 && enpassantj == clickedj && clickedi < 7 && getPiece(position,clickedi+1,clickedj) == 1 && i == clickedi+1 && j == clickedj+1) {
        enpassanti = -1;
        enpassantj = -1;
        setPiece(position,0,clickedi+1,clickedj);
        return true;
      }
      
      if (((clickedi == i && clickedj == j-1 && getPiece(position,i,j) == 0) || (clickedj == 1 && clickedi == i && clickedj == j-2 && getPiece(position,i,j) == 0) || (abs(clickedi-i) == 1 && clickedj == j-1 && getPiece(position,i,j) > 0)) && !inCheck(i,j,clickedi,clickedj)) { //if move forward one then check space in front, if move forward two on seventh row then check 2 spaces in front
        if (checkFree(position,i,j,clickedi,clickedj)) {
          if (clickedj == 1 && clickedi == i && clickedj == j-2 && getPiece(position,i,j) == 0) {
            enpassanti = i;
            enpassantj = j;
          } else {
            enpassanti = -1;
            enpassantj = -1;
          }
          
          return true;
        }
      }
      return false;
    case 1: //wpawn
      if (enpassanti == clickedi-1 && enpassantj == clickedj && clickedi > 0 && getPiece(position,clickedi-1,clickedj) == -1 && i == clickedi-1 && j == clickedj-1) {
        enpassanti = -1;
        enpassantj = -1;
        setPiece(position,0,clickedi-1,clickedj);
        return true;
      }
      if (enpassanti == clickedi+1 && enpassantj == clickedj && clickedi < 7 && getPiece(position,clickedi+1,clickedj) == -1 && i == clickedi+1 && j == clickedj-1) {
        enpassanti = -1;
        enpassantj = -1;
        setPiece(position,0,clickedi+1,clickedj);
        return true;
      }
      
      if (((clickedi == i && clickedj == j+1 && getPiece(position,i,j) == 0) || (clickedj == 6 && clickedi == i && clickedj == j+2 && getPiece(position,i,j) == 0) || (abs(clickedi-i) == 1 && clickedj == j+1 && getPiece(position,i,j) < 0)) && !inCheck(i,j,clickedi,clickedj)) { //if move forward one then check space in front, if move forward two on seventh row then check 2 spaces in front
        if (checkFree(position,i,j,clickedi,clickedj)) {
          if (clickedj == 6 && clickedi == i && clickedj == j+2 && getPiece(position,i,j) == 0) {
            enpassanti = i;
            enpassantj = j;
          } else {
            enpassanti = -1;
            enpassantj = -1;
          }
          
          return true;
        }
      }
      return false;
    case 2: //wknight
      if (((abs(clickedi-i) == 2 && abs(clickedj-j) == 1) || (abs(clickedi-i) == 1 && abs(clickedj-j) == 2)) && !inCheck(i,j,clickedi,clickedj)) {
        setPiece(position,0,i,j);
        enpassanti = -1;
        enpassantj = -1;
        return true;
      }
      return false;
    case 3: //wbishop
      if ((abs(clickedi - i) == abs(clickedj - j)) && !inCheck(i,j,clickedi,clickedj)) {
        if (checkFree(position,i,j,clickedi,clickedj)) {
          setPiece(position,0,i,j);
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
      }
      return false;
    case 4: //wrook
      if (((clickedi == i || clickedj == j) && !inCheck(i,j,clickedi,clickedj)) && checkFree(position,i,j,clickedi,clickedj)) {
        if (clickedi == 0 && clickedj == 7) {
          bCastleleft = false;
        }
        if (clickedi == 7 && clickedj == 7) {
          bCastleright = false;
        }
        
        setPiece(position,0,i,j);
        enpassanti = -1;
        enpassantj = -1;
        return true;
      }
      return false;
    case 5: //wqueen
      if ((abs(clickedi - i) == abs(clickedj - j) || clickedi == i || clickedj == j) && !inCheck(i,j,clickedi,clickedj)) {
        if (checkFree(position,i,j,clickedi,clickedj)) {
          setPiece(position,0,i,j);
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
      }
      return false;
    case 6: //wking
      if (((abs(clickedi-i) == 0 && abs(clickedj-j) == 1) || (abs(clickedi-i) == 1 && abs(clickedj-j) == 0) || (abs(clickedi-i) == 1 && abs(clickedj-j) == 1)) && !inCheck(i,j,clickedi,clickedj)) {
        setPiece(position,0,i,j);
        enpassanti = -1;
        enpassantj = -1;
        return true;
      } else {
        if (wCastleleft == true && checkFree(position,i,j,clickedi,clickedj) && i == 2 && j == 7 && !inCheck(i,j,i,j)) {
          setPiece(position,0,0,7);
          setPiece(position,4,3,7);
          wCastleleft = false;
          wCastleright = false;
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
        if (wCastleright == true && checkFree(position,i,j,clickedi,clickedj) && i == 6 && j == 7 && !inCheck(i,j,i,j)) {
          setPiece(position,0,7,7);
          setPiece(position,4,5,7);
          wCastleleft = false;
          wCastleright = false;
          enpassanti = -1;
          enpassantj = -1;
          return true;
        }
      }
      return false;
    default:
      return false;
  }
}
