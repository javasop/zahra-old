

#import "ZScustomcheckout.h"

@implementation ZScustomcheckout
@synthesize productImg,productLbl,itempriceLbl,itemtotalLbl,giftBtn,giftwrapBtn,removeBtn,qtyBtnUp,qtyBtnDown,textFieldQty,qtyLable;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        if (app.device==0) {
            productImg=[[UIImageView alloc] initWithFrame:CGRectMake(1, 17, 45, 45)];
            productLbl=[[UILabel alloc] initWithFrame:CGRectMake(54, 8, 85, 21)];
            itempriceLbl=[[UILabel alloc] initWithFrame:CGRectMake(125, 8, 89, 21)]; 
            itemtotalLbl=[[UILabel alloc] initWithFrame:CGRectMake(225, 8, 94, 21)];
            qtyLable=[[UILabel alloc] initWithFrame:CGRectMake(53, 42, 24, 21)];
            giftBtn=[[UIButton alloc] initWithFrame:CGRectMake(143, 40, 50, 24)];
            giftwrapBtn=[[UIButton alloc] initWithFrame:CGRectMake(197, 40, 57, 24)];
            removeBtn=[[UIButton alloc] initWithFrame:CGRectMake(259, 40, 57, 24)];
            qtyBtnDown=[[UIButton alloc] initWithFrame:CGRectMake(109, 53, 28, 24)];
            qtyBtnUp=[[UIButton alloc] initWithFrame:CGRectMake(109, 28, 28, 24)];
            textFieldQty = [[UITextField alloc] initWithFrame:CGRectMake(77, 43, 30,20)];
            qtyBtnUp.titleLabel.font = [UIFont systemFontOfSize:11.0];  
            qtyBtnDown.titleLabel.font = [UIFont systemFontOfSize:11.0]; 
            giftBtn.titleLabel.font = [UIFont systemFontOfSize:11.0]; 
            giftwrapBtn.titleLabel.font = [UIFont systemFontOfSize:11.0]; 
            removeBtn.titleLabel.font = [UIFont systemFontOfSize:11.0]; 
            productLbl.font =[UIFont fontWithName:@"Helvetica" size:12.0];
            itempriceLbl.font =[UIFont fontWithName:@"Helvetica" size:12.0];
            itemtotalLbl.font =[UIFont fontWithName:@"Helvetica" size:12.0];
            qtyLable.font =[UIFont fontWithName:@"Helvetica" size:11.0];
            textFieldQty.font = [UIFont systemFontOfSize:9.0];
        }
        else{
            productImg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 90)];
            productLbl=[[UILabel alloc] initWithFrame:CGRectMake(130, 10, 170, 22)];
            itempriceLbl=[[UILabel alloc] initWithFrame:CGRectMake(340, 10, 170, 22)]; 
            itemtotalLbl=[[UILabel alloc] initWithFrame:CGRectMake(575, 10, 170, 22)];
            qtyLable=[[UILabel alloc] initWithFrame:CGRectMake(130, 55, 40, 30)];
            giftBtn=[[UIButton alloc] initWithFrame:CGRectMake(310, 55, 72, 30)];
            giftwrapBtn=[[UIButton alloc] initWithFrame:CGRectMake(430, 55, 100, 30)];
            removeBtn=[[UIButton alloc] initWithFrame:CGRectMake(610, 55, 100, 30)];
            qtyBtnDown=[[UIButton alloc] initWithFrame:CGRectMake(230, 75, 40, 30)];
            qtyBtnUp=[[UIButton alloc] initWithFrame:CGRectMake(230, 40, 40, 30)];
            textFieldQty = [[UITextField alloc] initWithFrame:CGRectMake(175, 55, 50,30)];
            textFieldQty.font = [UIFont systemFontOfSize:17.0];
        }
        productImg.hidden = TRUE;
        
        productLbl.textAlignment = UITextAlignmentLeft;
        productLbl.textColor = [UIColor blackColor];
        productLbl.hidden = TRUE;
        
        itempriceLbl.textAlignment = UITextAlignmentLeft;
        itempriceLbl.textColor = [UIColor blackColor];
        itempriceLbl.hidden = TRUE;
       
        itemtotalLbl.textAlignment = UITextAlignmentLeft;
        itemtotalLbl.textColor = [UIColor blackColor];
        itemtotalLbl.hidden = TRUE;
        
        qtyLable.textAlignment = UITextAlignmentLeft;
        qtyLable.text = @"عدد :";
        qtyLable.textColor = [UIColor blackColor];
        qtyLable.hidden = TRUE;
        
        giftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [giftBtn setTitle:@"Gift" forState:UIControlStateNormal];
        giftBtn.hidden = TRUE;
        
        giftwrapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [giftwrapBtn setTitle:@"Gift Wrap" forState:UIControlStateNormal];
        giftwrapBtn.hidden = TRUE;        
        
        removeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [removeBtn setTitle:@"حذف" forState:UIControlStateNormal];
        removeBtn.hidden = TRUE;
        
        qtyBtnDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [qtyBtnDown setTitle:@"\\/" forState:UIControlStateNormal];
        qtyBtnDown.hidden = TRUE;
        
        
        qtyBtnUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [qtyBtnUp setTitle:@"/\\" forState:UIControlStateNormal];
        qtyBtnUp.hidden = TRUE;
        
        
        textFieldQty.borderStyle = UITextBorderStyleRoundedRect;
		textFieldQty.textColor = [UIColor blackColor]; //text color
		textFieldQty.backgroundColor = [UIColor whiteColor]; //background color
        textFieldQty.textAlignment = UITextAlignmentCenter;
		textFieldQty.hidden=TRUE;

        [self.contentView addSubview:productLbl];
        [self.contentView addSubview:productImg];
        [self.contentView addSubview:itempriceLbl];
        [self.contentView addSubview:itemtotalLbl];
        [self.contentView addSubview:giftBtn];
        [self.contentView addSubview:giftwrapBtn];
        [self.contentView addSubview:removeBtn];
        [self.contentView addSubview:qtyBtnDown];
        [self.contentView addSubview:qtyBtnUp];
        [self.contentView addSubview:textFieldQty];
        [self.contentView addSubview:qtyLable];
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
